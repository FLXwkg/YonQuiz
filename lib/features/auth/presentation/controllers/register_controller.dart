import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/datasources/local_auth_datasource.dart';
import '../../domain/entities/user_entity.dart';
import '../../../../core/routes/app_routes.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends GetxController {
  final LocalAuthDatasource _datasource = LocalAuthDatasource();
  final formKey = GlobalKey<FormState>();

  // Champs du formulaire = variables
  final pseudoController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePassword = true.obs;
  final confirmPasswordController = TextEditingController();
  final obscureConfirmPassword = true.obs;

  final selectedCamp = Rx<String?>(null);
  final selectedGender = Rx<String?>(null);
  final isLoading = false.obs;

  //  MÉTHODES TOGGLE 
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  // SÉLECTION CAMP & GENRE
  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  void selectCamp(String camp) {
    selectedCamp.value = camp;
  }

  Future<void> createAccount() async {
    if (!formKey.currentState!.validate()) return;
    
    if (selectedCamp.value == null) {
      Get.snackbar(
        '⚠️ Camp manquant',
        'Choisis ton camp : Marine ou Pirate !',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }
    
    if (selectedGender.value == null) {
      Get.snackbar(
        '⚠️ Genre manquant',
        'Indique si tu es un homme ou une femme',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    // VALIDATION MDP
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      Get.snackbar(
        '⚠️ Mots de passe différents',
        'Les deux mots de passe doivent être identiques',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    try {
      final existingUser = await _datasource.getUserByPseudo(
        pseudoController.text.trim(),
      );

      if (existingUser != null) {
        Get.snackbar(
          '⚠️ Pseudo déjà pris',
          'Ce pseudo existe déjà, choisis-en un autre',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        isLoading.value = false;
        return;
      }

      final newUserEntity = UserEntity(
        id: const Uuid().v4(),
        pseudo: pseudoController.text.trim(),
        camp: selectedCamp.value!,
        gender: selectedGender.value!,
        email: emailController.text.trim().isEmpty 
            ? null 
            : emailController.text.trim(),
        createdAt: DateTime.now(),
        password: passwordController.text.trim(),
      );

      await _datasource.saveUser(newUserEntity);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('has_created_account', true);
      await prefs.setBool('is_logged_in', true);
      await prefs.setString('current_user_id', newUserEntity.id);

      Get.snackbar(
        '🎉 Bienvenue ${newUserEntity.pseudo} !',
        'Ton compte ${newUserEntity.camp == 'pirate' ? '🏴‍☠️' : '⚓'} a été créé',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      await Future.delayed(const Duration(seconds: 1));
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      Get.snackbar(
        '❌ Erreur',
        'Impossible de créer le compte: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    pseudoController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose(); 
    super.onClose();
  }
}
