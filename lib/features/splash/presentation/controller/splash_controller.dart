import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();

    final hasCreatedAccount = prefs.getBool('has_created_account') ?? false;
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    print('🔍 hasCreatedAccount: $hasCreatedAccount');
    print('🔍 isLoggedIn: $isLoggedIn');

    if (!hasCreatedAccount) {
      // ✅ Pas de compte → TOUJOURS montrer l'onboarding
      print('📱 → ONBOARDING (pas de compte créé)');
      Get.offAllNamed(AppRoutes.onboarding);
    } else if (!isLoggedIn) {
      // ✅ Compte créé mais déconnecté → LOGIN
      print('📱 → LOGIN (compte créé mais pas connecté)');
      Get.offAllNamed(AppRoutes.login);
    } else {
      // ✅ Connecté → HOME
      print('📱 → HOME (connecté)');
      Get.offAllNamed(AppRoutes.home);
    }
  }
}
