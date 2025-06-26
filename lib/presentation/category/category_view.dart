import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presentation/category/category_widget.dart';
import 'category_controller.dart';
import 'package:flutter_mvc/flutter_mvc.dart';

class CategoryView extends MvcView<CategoryController>   {
  @override
  Widget buildView() {
    final categories = controller.model.categories;
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocalizations.of(context)!.categoriesTitle),
        centerTitle: true),
      body: Column(
        children: <Widget>[
          Expanded(child: CategoryGridWidget(categories: categories))
        ],
      )
    );
  }
}