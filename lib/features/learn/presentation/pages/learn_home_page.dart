import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';

class LearnHomePage extends StatelessWidget {
  const LearnHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 Apprentissage'),
        backgroundColor: const Color(0xFFE63946),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1D3557), Color(0xFF457B9D)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Titre
                const Text(
                  'Que veux-tu apprendre ?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF1FAEE),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 60),

                // Carte Personnages
                _CategoryCard(
                  icon: Icons.people,
                  title: 'Personnages',
                  description: 'Découvre tous les pirates de One Piece',
                  color: const Color(0xFFE63946),
                  onTap: () => Get.toNamed(AppRoutes.charactersList),
                ),

                const SizedBox(height: 24),

                // Carte Fruits du Démon
                _CategoryCard(
                  icon: Icons.eco,
                  title: 'Fruits du Démon',
                  description: 'Explore les pouvoirs mystérieux',
                  color: const Color(0xFF06D6A0),
                  onTap: () => Get.toNamed(AppRoutes.fruitsList),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget pour les cartes de catégories
class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(
            color: const Color(0xFFFFD60A),
            width: 3,
          ),
        ),
        child: Row(
          children: [
            // Icône
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 50,
                color: const Color(0xFFF1FAEE),
              ),
            ),

            const SizedBox(width: 24),

            // Texte
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF1FAEE),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFFF1FAEE).withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            // Flèche
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFF1FAEE),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}