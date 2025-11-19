abstract class AppRoutes {
  // Onboarding & Auth
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String register = '/register';  // ✅ AJOUTÉ
  static const String login = '/login';
  
  // Home
  static const String home = '/home';  // ✅ AJOUTÉ

  // Quiz
  static const String quizSetup = '/quiz/setup';
  static const String quizGame = '/quiz/game';
  static const String quizResult = '/quiz/result';

  // Learn
  static const String learnHome = '/learn';
  static const String charactersList = '/learn/characters';
  static const String fruitsList = '/learn/fruits';
  static const String detail = '/learn/detail';
}
