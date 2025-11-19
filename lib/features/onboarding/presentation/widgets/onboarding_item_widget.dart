import 'package:flutter/material.dart';
import '../../domain/entities/onboarding_item.dart';

class OnboardingItemWidget extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image (pour l'instant une icône, tu mettras une vraie image)
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: item.imagePath.contains('onboarding1')
                  ? const Icon(Icons.groups, size: 120, color: Colors.amber)
                  : item.imagePath.contains('onboarding2')
                      ? const Icon(Icons.quiz, size: 120, color: Colors.amber)
                      : const Icon(Icons.emoji_events, size: 120, color: Colors.amber),
            ),
          ),
          
          const SizedBox(height: 60),
          
          // Titre
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Description
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
