import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/local_auth_datasource.dart';
import '../../../../core/routes/app_routes.dart';

class LoginController extends GetxController {
  final LocalAuthDatasource _datasource = LocalAuthDatasource();
  final formKey = GlobalKey<FormState>();

  // Champs du formulaire
  final pseudoController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final obscurePassword = true.obs; // Pour le bouton "voir/masquer" mot de passe

  /// Connexion
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    try {
      final pseudo = pseudoController.text.trim();
      final password = passwordController.text.trim();

      // Récupère l'utilisateur
      final user = await _datasource.getUserByPseudo(pseudo);

      if (user == null) {
        Get.snackbar(
          '❌ Utilisateur introuvable',
          'Ce pseudo n\'existe pas',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return;
      }

      // Vérifie le mot de passe
      if (user.password != password) {
        Get.snackbar(
          '❌ Mot de passe incorrect',
          'Vérifie ton mot de passe',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return;
      }

      // Connexion réussie !
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('current_user_id', user.id);

      Get.snackbar(
        '🎉 Bienvenue ${user.pseudo} !',
        'Connexion réussie ${user.camp == 'pirate' ? '🏴‍☠️' : '⚓'}',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        '❌ Erreur',
        'Impossible de se connecter: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Aller vers la page d'inscription
  void goToRegister() {
    Get.toNamed(AppRoutes.register);
  }

  /// Toggle visibilité mot de passe
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  @override
  void onClose() {
    pseudoController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
