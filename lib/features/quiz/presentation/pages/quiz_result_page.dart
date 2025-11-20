import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quiz_controller.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizController>();

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
          child: SingleChildScrollView( // ✅ Ajout du SingleChildScrollView
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min, // ✅ Changé de max à min
                children: [
                  const SizedBox(height: 20), // ✅ Ajout d'espace en haut
                  
                  // Titre
                  const Text(
                    '🏴‍☠️ Quiz Terminé !',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF1FAEE),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 40),

                  // Score principal
                  Obx(() {
                    final score = controller.score.value;
                    final total = controller.questions.length;
                    final percentage = (score / total * 100).round();
                    
                    // Emoji selon le score
                    String emoji;
                    String message;
                    Color scoreColor;
                    
                    if (percentage >= 80) {
                      emoji = '🏆';
                      message = 'Excellent !';
                      scoreColor = const Color(0xFFFFD60A);
                    } else if (percentage >= 60) {
                      emoji = '⭐';
                      message = 'Bien joué !';
                      scoreColor = const Color(0xFF06D6A0);
                    } else if (percentage >= 40) {
                      emoji = '👍';
                      message = 'Pas mal !';
                      scoreColor = const Color(0xFF457B9D);
                    } else {
                      emoji = '💪';
                      message = 'Continue à t\'entraîner !';
                      scoreColor = const Color(0xFFE63946);
                    }

                    return Column(
                      children: [
                        // Emoji
                        Text(
                          emoji,
                          style: const TextStyle(fontSize: 80),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Message
                        Text(
                          message,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: scoreColor,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Score card
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1D3557),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: scoreColor,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: scoreColor.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Ton Score',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFA8DADC),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '$score',
                                    style: TextStyle(
                                      fontSize: 72,
                                      fontWeight: FontWeight.bold,
                                      color: scoreColor,
                                      height: 1,
                                    ),
                                  ),
                                  Text(
                                    ' / $total',
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFF1FAEE),
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '$percentage%',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: scoreColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),

                  const SizedBox(height: 50),

                  // Statistiques
                  Obx(() {
                    final correct = controller.score.value;
                    final wrong = controller.questions.length - correct;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Bonnes réponses
                        _StatCard(
                          icon: Icons.check_circle,
                          color: const Color(0xFF06D6A0),
                          label: 'Correctes',
                          value: correct.toString(),
                        ),

                        // Mauvaises réponses
                        _StatCard(
                          icon: Icons.cancel,
                          color: const Color(0xFFE63946),
                          label: 'Incorrectes',
                          value: wrong.toString(),
                        ),
                      ],
                    );
                  }),

                  const SizedBox(height: 50), // ✅ Espace avant les boutons

                  // Boutons
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Rejouer
                      ElevatedButton.icon(
                        onPressed: () {
                          controller.restart();
                          Get.back();
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFD60A),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.replay),
                        label: const Text(
                          'REJOUER',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Retour menu
                      OutlinedButton.icon(
                        onPressed: () {
                          controller.reset();
                          Get.offAllNamed('/home'); // ✅ Retour vers home au lieu de 2x back
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFF1FAEE),
                          side: const BorderSide(
                            color: Color(0xFFF1FAEE),
                            width: 2,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.home),
                        label: const Text(
                          'MENU PRINCIPAL',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 40), // ✅ Espace en bas
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget pour les cartes de statistiques
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1D3557),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 40,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFFA8DADC),
            ),
          ),
        ],
      ),
    );
  }
}