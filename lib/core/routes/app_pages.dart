import 'package:get/get.dart';
import 'package:yon_quiz/features/home/presentation/pages/home_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/bindings/onboarding_binding.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/quiz/presentation/pages/quiz_setup_page.dart';
import '../../features/quiz/presentation/pages/quiz_game_page.dart';
import '../../features/quiz/presentation/pages/quiz_result_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/bindings/register_binding.dart';
import '../../features/auth/presentation/bindings/login_binding.dart';
import 'app_routes.dart';


class AppPages {
  static final routes = [
    // Onboarding & Auth
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    
 GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    
    
    // ✅ ROUTE TEMPORAIRE POUR /home
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage()
    ),

    // Quiz
    GetPage(
      name: AppRoutes.quizSetup,
      page: () => const QuizSetupPage(),
    ),
    GetPage(
      name: AppRoutes.quizGame,
      page: () => const QuizGamePage(),
    ),
    GetPage(
      name: AppRoutes.quizResult,
      page: () => const QuizResultPage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: LoginBinding(), // 
    ),

    // Learn
    // GetPage(
    //   name: AppRoutes.learnHome,
    //   page: () => const LearnHomePage(),
    // ),
  ];
}
