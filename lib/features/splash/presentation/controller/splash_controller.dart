import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    // Attendre 3 secondes (animation du splash)
    await Future.delayed(const Duration(seconds: 3));

    // Vérifier si c'est la première fois
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('has_seen_onboarding') ?? false;

    print('🔍 DEBUG: hasSeenOnboarding = $hasSeenOnboarding'); // Pour débugger

    if (!hasSeenOnboarding) {
      // ✅ Première visite → Onboarding
      print('📱 Navigation: Vers ONBOARDING');
      Get.offAllNamed('/onboarding');
    } else {
      // Déjà vu l'onboarding → Vérifier si connecté
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
      
      if (isLoggedIn) {
        print('📱 Navigation: Vers HOME (connecté)');
        Get.offAllNamed('/home'); // Ewen créera cette route
      } else {
        print('📱 Navigation: Vers LOGIN (pas connecté)');
        Get.offAllNamed('/login');
      }
    }
  }
}
