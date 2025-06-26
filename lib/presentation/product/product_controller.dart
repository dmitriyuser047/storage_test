import 'package:flutter_application_1/core/api/product/product_api.dart';
import 'package:flutter_application_1/domain/entity/product/product.dart';
import 'package:flutter_application_1/presentation/product/product_model.dart';
import 'package:flutter_application_1/presentation/product/product_view.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

class ProductController extends MvcController<ProductModel> {
  late final ProductApi productApi;
  late final int categoryId;

  int _currentIndex = 0;
  final int _pageSize = 8;
  bool _isLoading = false;
  bool _hasMore = true;
  bool _loadedOnce = false;

  List<Product> _allProducts = [];

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  ProductController(this.categoryId);

  @override
  void init() {
    super.init();
    productApi = getService<ProductApi>();
    _loadAllProducts();
  }

  Future<void> _loadAllProducts() async {
    if (_loadedOnce) return;
    _isLoading = true;
    update();

    try {
      _allProducts = await productApi.getProductList(categoryId: categoryId);
      model.products.clear();
      _currentIndex = 0;
      _hasMore = true;
      _loadedOnce = true;

      _appendNextPage();
    } catch (e) {
      print('Error loading products: $e');
    } finally {
      _isLoading = false;
      update();
    }
  }

  void _appendNextPage() {
    if (!_hasMore) return;

    final nextChunk = _allProducts.skip(_currentIndex).take(_pageSize).toList();
    model.products.addAll(nextChunk);
    _currentIndex += nextChunk.length;

    if (_currentIndex >= _allProducts.length) {
      _hasMore = false;
    }
  }

  void loadNextPage() {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    update();

    Future.delayed(const Duration(milliseconds: 500), () {
      _appendNextPage();
      _isLoading = false;
      update();
    });
  }

  @override
  MvcView<MvcController> view() => ProductView();
}
