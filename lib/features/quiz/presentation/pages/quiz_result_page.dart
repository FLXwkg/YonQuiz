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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  
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
                          Get.offAllNamed('/home');
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
                  
                  const SizedBox(height: 40),

                  // Récapitulatif des réponses
                  const Text(
                    'Récapitulatif',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF1FAEE),
                    ),
                  ),
                  
                  const SizedBox(height: 20),

                  // Liste des questions/réponses
                  Obx(() {
                    return Column(
                      children: List.generate(
                        controller.questions.length,
                        (index) {
                          final question = controller.questions[index];
                          final userAnswerIndex = controller.userAnswers[index];
                          final isCorrect = userAnswerIndex == question.correctAnswerIndex;
                          
                          final userAnswer = userAnswerIndex != null 
                              ? question.options[userAnswerIndex]
                              : 'Pas de réponse';
                          final correctAnswer = question.correctAnswer;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isCorrect 
                                    ? const Color(0xFF06D6A0).withOpacity(0.15)
                                    : const Color(0xFFE63946).withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isCorrect 
                                      ? const Color(0xFF06D6A0)
                                      : const Color(0xFFE63946),
                                  width: 2,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Numéro et icône
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isCorrect 
                                              ? const Color(0xFF06D6A0)
                                              : const Color(0xFFE63946),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'Q${index + 1}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFF1FAEE),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Icon(
                                        isCorrect ? Icons.check_circle : Icons.cancel,
                                        color: isCorrect 
                                            ? const Color(0xFF06D6A0)
                                            : const Color(0xFFE63946),
                                        size: 28,
                                      ),
                                    ],
                                  ),
                                  
                                  const SizedBox(height: 12),
                                  
                                  // Question
                                  Text(
                                    question.question,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFF1FAEE),
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 8),
                                  const Divider(color: Color(0xFF457B9D)),
                                  const SizedBox(height: 8),
                                  
                                  // Ta réponse
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Ta réponse : ',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFFA8DADC),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          userAnswer,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: isCorrect 
                                                ? const Color(0xFF06D6A0)
                                                : const Color(0xFFE63946),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  // Bonne réponse (si mauvaise réponse)
                                  if (!isCorrect) ...[
                                    const SizedBox(height: 4),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Bonne réponse : ',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFFA8DADC),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            correctAnswer,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF06D6A0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}