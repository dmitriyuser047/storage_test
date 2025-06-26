import 'package:flutter_application_1/core/api/base/base_api.dart';
import 'package:flutter_application_1/domain/entity/product/product.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ProductApiEndpoints {
  static const getProductList = "/common/product/list";
  static const getDetailsOfProduct = "/common/product/details";
}

class ProductApi extends BaseApi {

   ProductApi._internal({required super.dio}) : super(
    baseUrl: dotenv.env['BASE_URL'] ?? '',
    apiKey: dotenv.env['API_KEY'] ?? '',
  );

  static ProductApi? _instance;

  static ProductApi getInstance({required dio}) {
    _instance ??= ProductApi._internal(dio: dio);
    return _instance!;
  }

  Future<List<Product>> getProductList({
    required int categoryId,
    SuccessHandler<List<Product>>? onSuccess,
    ErrorHandler? onError,
  }) async {
    final fullUrl = '${baseUrl}${ProductApiEndpoints.getProductList}?appKey=$apiKey';
    print('Requesting category list: $fullUrl');
    return await getRequest<List<Product>>(
      endpoint: ProductApiEndpoints.getProductList,
      queryParameters: {
        'categoryId': categoryId,
      },
      parser: (json) {
        final List<dynamic> productJson = json['data'];
        return productJson.map((e) => Product.fromJson(e)).toList();
      },
      onSuccess: onSuccess,
      onError: onError,
    );
  }

  Future<Product> getDetailsOfProduct({
    required int productId,
    SuccessHandler<Product>? onSuccess,
    ErrorHandler? onError,
  }) async {
    final fullUrl = '${baseUrl}${ProductApiEndpoints.getDetailsOfProduct}?appKey=$apiKey';
    print('Requesting category list: $fullUrl');
    return await getRequest<Product>(
      endpoint: ProductApiEndpoints.getDetailsOfProduct,
      queryParameters: {
        'productId': productId,
      },
      parser: (json) {
        final dynamic productJson = json['data'];
        return Product.fromJson(productJson);
      },
      onSuccess: onSuccess,
      onError: onError,
    );
  }


}