import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_pages.dart';  // ✅ Import centralisé
import 'core/routes/app_routes.dart'; // ✅ Import des routes

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YonQuiz',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.splash,  // ✅ Utilise la constante
      getPages: AppPages.routes,       // ✅ Utilise les routes centralisées
    );
  }
}
