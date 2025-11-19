import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Remplacer par le vrai nom de l'utilisateur une fois le login fait
    final String userName = 'Capitaine'; 

    return Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // Titre et bienvenue
                const Text(
                  '🏴‍☠️ YonQuiz',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFD60A),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Bienvenue, $userName !',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF1FAEE),
                  ),
                  textAlign: TextAlign.center,
                ),

                const Spacer(),

                // Bouton Apprendre
                _MenuCard(
                  icon: Icons.school,
                  title: 'Apprendre',
                  description: 'Découvre les personnages et les fruits du démon',
                  color: const Color(0xFF06D6A0),
                  onTap: () {
                    Get.toNamed(AppRoutes.learnHome);
                    // TODO: Ton pote implémentera cette page
                  },
                ),

                const SizedBox(height: 20),

                // Bouton Quiz
                _MenuCard(
                  icon: Icons.quiz,
                  title: 'Quiz',
                  description: 'Teste tes connaissances sur One Piece',
                  color: const Color(0xFFE63946),
                  onTap: () {
                    Get.toNamed(AppRoutes.quizSetup);
                  },
                ),

                const SizedBox(height: 20),

                // Bouton Multijoueur (désactivé pour l'instant)
                _MenuCard(
                  icon: Icons.people,
                  title: 'Multijoueur',
                  description: 'Affronte tes amis (bientôt disponible)',
                  color: const Color(0xFF457B9D),
                  isDisabled: true,
                  onTap: () {
                    Get.snackbar(
                      'Bientôt disponible',
                      'Le mode multijoueur arrive prochainement !',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: const Color(0xFF457B9D),
                      colorText: const Color(0xFFF1FAEE),
                    );
                  },
                ),

                const Spacer(),

                // Bouton Déconnexion (temporaire)
                TextButton.icon(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.login);
                  },
                  icon: const Icon(Icons.logout, color: Color(0xFFF1FAEE)),
                  label: const Text(
                    'Déconnexion',
                    style: TextStyle(color: Color(0xFFF1FAEE)),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget Card pour les options du menu
class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;
  final bool isDisabled;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled ? onTap : onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDisabled ? color.withOpacity(0.5) : color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isDisabled
              ? []
              : [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
          border: Border.all(
            color: const Color(0xFFFFD60A),
            width: isDisabled ? 0 : 2,
          ),
        ),
        child: Row(
          children: [
            // Icône
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: const Color(0xFFF1FAEE),
              ),
            ),

            const SizedBox(width: 20),

            // Texte
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF1FAEE),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFFF1FAEE).withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),

            // Flèche
            if (!isDisabled)
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFFF1FAEE),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}