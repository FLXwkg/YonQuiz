import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/onboarding_controller.dart';
import '../widgets/onboarding_item_widget.dart';
import '../widgets/onboarding_page_indicator.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Column(
          children: [
            // Bouton "Passer" en haut à droite
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: controller.skipOnboarding,
                  child: const Text(
                    'Passer',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            
            // PageView avec les 3 écrans
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  return OnboardingItemWidget(
                    item: controller.items[index],
                  );
                },
              ),
            ),
            
            // Indicateur de pagination (SANS Obx car le widget gère déjà l'animation)
            OnboardingPageIndicator(
              controller: controller.pageController,
              count: controller.items.length,
            ),
            
            const SizedBox(height: 40),
            
            // Bouton Suivant/Commencer (AVEC Obx pour changer le texte)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Obx(() => SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: controller.nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: const Color(0xFF1A1A2E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                  ),
                  child: Text(
                    controller.currentPage.value == controller.items.length - 1
                        ? '🏴‍☠️ Commencer l\'aventure !'
                        : 'Suivant',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
