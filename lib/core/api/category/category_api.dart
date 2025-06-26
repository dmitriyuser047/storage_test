

import 'package:flutter_application_1/core/api/base/base_api.dart';
import 'package:flutter_application_1/domain/entity/category/category.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class CategoryApiEndpoints {
  static const getCategoryList = "/common/category/list";
}

class CategoryApi extends BaseApi {
  CategoryApi._internal({required super.dio}) : super(
    baseUrl: dotenv.env['BASE_URL'] ?? '',
    apiKey: dotenv.env['API_KEY'] ?? '',
  );

  static CategoryApi? _instance;

  static CategoryApi getInstance({required dio}) {
    _instance ??= CategoryApi._internal(dio: dio);
    return _instance!;
  }

  Future<List<Category>> getListCategory({
    SuccessHandler<List<Category>>? onSuccess,
    ErrorHandler? onError,
  }) async {
    final fullUrl = '${baseUrl}${CategoryApiEndpoints.getCategoryList}?appKey=$apiKey';
    print('Requesting category list: $fullUrl');

    return await getRequest<List<Category>>(
      endpoint: CategoryApiEndpoints.getCategoryList,
      queryParameters: {
        'appKey': apiKey,
      },
      parser: (json) {
        final List<dynamic> categoryJson = json['data']['categories'];
        return categoryJson.map((e) => Category.fromJson(e)).toList();
      },
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}
