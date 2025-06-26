
import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entity/category/category.dart';
import 'package:flutter_application_1/presentation/product/product_controller.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
import 'package:flutter_application_1/presentation/product/product_model.dart';

class CategoryGridWidget extends MvcStatelessWidget {
  const CategoryGridWidget({
    required this.categories,
    super.key,
    super.id = 'category-grid',
    super.classes,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3 / 3,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => Mvc(
                create: () => ProductController(category.categoryId),
                model: ProductModel(),
                ),
              ),
            );
          },
          child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  category.fullName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                child: Image.network(
                  category.imageUrl,
                  fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          ),
        );
      }
    );
  }
}