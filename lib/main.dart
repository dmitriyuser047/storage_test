import 'package:dio/dio.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_application_1/app.dart';
import 'package:flutter_application_1/core/api/category/category_api.dart' as CategoryApi;
import 'package:flutter_application_1/core/api/product/product_api.dart' as ProductApi;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final dio = Dio();

  runApp(
    MvcDependencyProvider(
      provider: (collection) {
        collection.addSingleton<Dio>((_) => dio);
        collection.addSingleton<CategoryApi.CategoryApi>(
          (c) => CategoryApi.CategoryApi.getInstance(dio: c.get<Dio>()),
        );
        collection.addSingleton<ProductApi.ProductApi>(
          (c) => ProductApi.ProductApi.getInstance(dio: c.get<Dio>()),
        );
      },
      child: const App(),
  )
  );
}
