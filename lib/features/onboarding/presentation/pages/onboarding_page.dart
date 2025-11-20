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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0F2027), // Bleu nuit profond
              Color(0xFF203A43), // Bleu océan
              Color(0xFF2C5364), // Bleu mer
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 🎯 Header avec Skip Button
              _buildHeader(),

              // 🏴‍☠️ PageView avec les écrans
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    return OnboardingItemWidget(item: controller.items[index]);
                  },
                ),
              ),

              // 📍 Indicateur de pagination
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: OnboardingPageIndicator(
                  controller: controller.pageController,
                  count: controller.items.length,
                ),
              ),

              // 🚀 Bouton d'action
              _buildActionButton(),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  /// Header avec bouton Skip
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo pirate
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.withOpacity(0.3)),
            ),
            child: const Text(
              '🏴‍☠️',
              style: TextStyle(fontSize: 24),
            ),
          ),

          // Bouton Passer
          TextButton(
            onPressed: controller.skipOnboarding,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              backgroundColor: Colors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Passer',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Bouton Suivant/Commencer
  Widget _buildActionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Obx(() {
        final isLastPage = controller.currentPage.value == controller.items.length - 1;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isLastPage
                  ? [Colors.amber, Colors.orange]
                  : [Colors.white, Colors.grey.shade300],
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: (isLastPage ? Colors.amber : Colors.white).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: controller.nextPage,
              borderRadius: BorderRadius.circular(30),
              child: Center(
                child: Text(
                  isLastPage ? '🏴‍☠️ Commencer l\'aventure !' : 'Suivant →',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isLastPage ? const Color(0xFF0F2027) : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
