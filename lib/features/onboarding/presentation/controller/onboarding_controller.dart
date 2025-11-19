import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/onboarding_item.dart';
import '../../../../core/routes/app_routes.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  final List<OnboardingItem> items = const [
    OnboardingItem(
      title: 'Rejoins l\'équipage !',
      description: 'Teste tes connaissances sur l\'univers de One Piece',
      imagePath: 'assets/images/onboarding1.png',
    ),
    OnboardingItem(
      title: 'Affronte les défis',
      description: 'Des quiz sur les arcs, personnages, et pouvoirs',
      imagePath: 'assets/images/onboarding2.png',
    ),
    OnboardingItem(
      title: 'Deviens Roi des Pirates !',
      description: 'Gravis les échelons et prouve ta valeur',
      imagePath: 'assets/images/onboarding3.png',
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < items.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      finishOnboarding();
    }
  }

  void skipOnboarding() {
    finishOnboarding();
  }

  Future<void> finishOnboarding() async {
    // ✅ Ne sauvegarde RIEN, juste navigue
    print('✅ Onboarding terminé, navigation vers INSCRIPTION');
    Get.offAllNamed(AppRoutes.register);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
