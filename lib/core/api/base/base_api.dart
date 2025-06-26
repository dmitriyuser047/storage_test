import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/api/base/api_exception.dart';

typedef SuccessHandler<T> = void Function(T data);
typedef ErrorHandler = void Function(Object error);

abstract class BaseApi {

  final Dio dio;

  final String baseUrl;

  final String apiKey;

  BaseApi({
    required this.dio,
    required this.baseUrl,
    required this.apiKey,
  }) {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  Map<String, dynamic> _addCommonParameters(Map<String, dynamic>? queryParameters) {
    return {
      if (queryParameters != null) ...queryParameters,
      'appKey': apiKey,
    };
  }

 Future<T> getRequest<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Options? options,
    required T Function(dynamic json) parser,
    SuccessHandler<T>? onSuccess,
    ErrorHandler? onError,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: _addCommonParameters(queryParameters),
        options: options,
      );
      final result = parser(response.data);
      
      onSuccess?.call(result);
      return result;
    } on DioException catch (e) {
      final apiException = _handleError(e);
      onError?.call(apiException);
      throw apiException;
    }
  }

    Future<T> postRequest<T>(
    String relativePath, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    required T Function(dynamic) onSuccess,
    Function(Exception)? onError,
  }) async {
    try {
      final response = await dio.post(
        relativePath,
        data: data,
        queryParameters: _addCommonParameters(queryParameters),
        options: options,
      );
      print('Raw response: ${response.data}');
      return onSuccess(response.data);
    } on DioException catch (e) {
      final apiException = _handleError(e);
      onError?.call(apiException);
      throw apiException;
    }
  }

  ApiException _handleError(DioException e) {
    String message;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        message = 'Connection timeout';
        break;
      case DioExceptionType.badResponse:
        message = 'Server error: ${e.response?.statusCode}';
        break;
      case DioExceptionType.cancel:
        message = 'Request cancelled';
        break;
      case DioExceptionType.connectionError:
        message = 'Connection error';
        break;
      default:
        message = 'Unexpected error: ${e.message ?? e.toString()}';
    }
    return ApiException(message, e.response?.statusCode);
  }
}
