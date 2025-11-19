import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/onboarding/presentation/bindings/onboarding_binding.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'core/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YonQuiz',
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashPage(),
        ),
        GetPage(
          name: '/onboarding',
          page: () => const OnboardingPage(),
          binding: OnboardingBinding(), // ✅ AJOUTÉ ICI
        ),
        GetPage(
          name: '/login',
          page: () => const LoginPage(),
        ),
        // D'autres routes seront ajoutées ici par Ewen
      ],
    );
  }
}
