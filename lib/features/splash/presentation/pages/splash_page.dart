import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import '../controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialise le controller
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E), // Bleu nuit pirate
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo animé (pour l'instant du texte, tu mettras une image plus tard)
            ZoomIn(
              duration: const Duration(milliseconds: 1500),
              child: const Icon(
                Icons.sailing, // Temporaire, tu mettras ton logo
                size: 120,
                color: Colors.amber,
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Titre
            FadeIn(
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(milliseconds: 500),
              child: const Text(
                'YON QUIZ',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Sous-titre
            FadeIn(
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(milliseconds: 1000),
              child: const Text(
                '⚓ Teste tes connaissances One Piece ⚓',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ),
            
            const SizedBox(height: 50),
            
            // Loading indicator
            FadeIn(
              duration: const Duration(milliseconds: 1000),
              delay: const Duration(milliseconds: 2000),
              child: const CircularProgressIndicator(
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
