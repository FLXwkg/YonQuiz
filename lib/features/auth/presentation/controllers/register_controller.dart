import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/datasources/local_auth_datasource.dart';
import '../../data/models/user_model.dart';
import '../../../../core/routes/app_routes.dart';
import 'package:uuid/uuid.dart';

class RegisterController extends GetxController {
  final LocalAuthDatasource _datasource = LocalAuthDatasource();
  final formKey = GlobalKey<FormState>();

  // Champs du formulaire
  final pseudoController = TextEditingController();
  final emailController = TextEditingController();
  
  final selectedCamp = Rx<String?>(null); // 'marine' ou 'pirate'
  final selectedGender = Rx<String?>(null); // 'homme' ou 'femme'
  final isLoading = false.obs;

  // Validation et création du compte
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

    isLoading.value = true;

    try {
      final user = UserModel(
        id: const Uuid().v4(),
        pseudo: pseudoController.text.trim(),
        camp: selectedCamp.value!,
        gender: selectedGender.value!,
        email: emailController.text.trim().isEmpty 
            ? null 
            : emailController.text.trim(),
        createdAt: DateTime.now(),
      );

      await _datasource.saveUser(user);

      Get.snackbar(
        '🎉 Bienvenue ${user.pseudo} !',
        'Ton compte ${user.camp == 'pirate' ? '🏴‍☠️' : '⚓'} a été créé',
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
    super.onClose();
  }
}
