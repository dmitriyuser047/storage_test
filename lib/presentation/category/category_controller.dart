
import 'package:flutter_application_1/core/api/category/category_api.dart';
import 'package:flutter_application_1/presentation/category/category_model.dart';
import 'package:flutter_application_1/presentation/category/category_view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

class CategoryController extends MvcController<CategoryModel> {

   late final CategoryApi categoryApi;

   @override
  void init() {
    super.init();
    categoryApi = getService<CategoryApi>();
    loadCategories();
  }

  void loadCategories() async {
    try {
      print("Sending request to category API...");
      final result = await categoryApi.getListCategory();
      model.categories = result;
      update();
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

   @override
  MvcView<MvcController> view() => CategoryView();
}