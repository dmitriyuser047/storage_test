import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/presentation/category/category_controller.dart';
import 'package:flutter_application_1/presentation/category/category_model.dart';
import 'package:flutter_mvc/flutter_mvc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'),
        Locale('en'),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Mvc(
        create: () => CategoryController(),
        model: CategoryModel(),
      ),
    );
  }

}