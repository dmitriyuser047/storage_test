import 'package:flutter_application_1/core/api/product/product_api.dart';
import 'package:flutter_application_1/presentation/detail/detail_model.dart';
import 'package:flutter_application_1/presentation/detail/detail_view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

class DetailController extends MvcController<DetailModel> {

  late final ProductApi productApi;
  late final int productId;    

  DetailController(this.productId);

   @override
  void init() {
    super.init();
    productApi = getService<ProductApi>();
    loadProducts();
  }

  void loadProducts() async {
    try {
      final result = await productApi.getDetailsOfProduct(productId: productId);
      print("result: $result");
      model.detailProduct = result;
      update();
    } catch (e) {
        print('Error loading categories: $e');
    }
  }

  @override
  MvcView<MvcController> view() => DetailView();
}