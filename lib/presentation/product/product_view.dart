import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presentation/detail/detail_controller.dart';
import 'package:flutter_application_1/presentation/detail/detail_model.dart';
import 'package:flutter_application_1/presentation/product/product_controller.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

class ProductView extends MvcView<ProductController>   {

 @override
  Widget buildView() {
    final products = controller.model.products;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.productsTitle),
        centerTitle: true,
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 3,
                        child: ListTile(
                          leading: Image.network(
                            product.imageUrl,
                            width: 60,
                            fit: BoxFit.fill,
                          ),
                          title: Text(product.title),
                          subtitle: Text('${product.price} ₽'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => Mvc(
                                  create: () => DetailController(product.productId),
                                  model: DetailModel(),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                if (controller.isLoading)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  )
                else if (controller.hasMore)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: ElevatedButton(
                      onPressed: controller.loadNextPage,
                      child: const Text('Загрузить ещё'),
                    ),
                  ),
              ],
            ),
    );
  }
}