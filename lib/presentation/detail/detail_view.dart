import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentation/detail/detail_controller.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

class DetailView extends MvcView<DetailController> {
  @override
  Widget buildView() {
    final product = controller.model.detailProduct;

    if (product == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.images.isNotEmpty)
              SizedBox(
                height: 200,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.images.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.images[index],
                        height: 200,
                        width: 200,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              )
            else
              Center(
                child: Image.network(
                  product.imageUrl,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              '${product.price} ₽',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              product.productDescription,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}