import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quiz_controller.dart';

class QuizGamePage extends StatelessWidget {
  const QuizGamePage({super.key});

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
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFFD60A),
                ),
              );
            }

            if (controller.questions.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Aucune question disponible',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFF1FAEE),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      child: const Text('Retour'),
                    ),
                  ],
                ),
              );
            }

            final question = controller.questions[controller.currentQuestionIndex.value];
            final progress = (controller.currentQuestionIndex.value + 1) / 
                            controller.questions.length;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header avec score et progression
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Score
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE63946),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFFD60A),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${controller.score.value} pts',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFF1FAEE),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Question number
                      Text(
                        'Question ${controller.currentQuestionIndex.value + 1}/${controller.questions.length}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF1FAEE),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Barre de progression
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                      backgroundColor: const Color(0xFF457B9D),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFFFD60A),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Question
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D3557),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFE63946),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFF1FAEE),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Options de réponses
                  Expanded(
                    child: ListView.builder(
                      itemCount: question.options.length,
                      itemBuilder: (context, index) {
                        final isSelected = controller.selectedAnswerIndex.value == index;
                        final isCorrect = index == question.correctAnswerIndex;
                        final hasAnswered = controller.hasAnswered.value;

                        Color backgroundColor;
                        Color borderColor;
                        
                        if (hasAnswered) {
                          if (isCorrect) {
                            backgroundColor = const Color(0xFF06D6A0);
                            borderColor = const Color(0xFF06D6A0);
                          } else if (isSelected) {
                            backgroundColor = const Color(0xFFE63946);
                            borderColor = const Color(0xFFE63946);
                          } else {
                            backgroundColor = const Color(0xFF457B9D);
                            borderColor = const Color(0xFF457B9D);
                          }
                        } else {
                          backgroundColor = isSelected
                              ? const Color(0xFFFFD60A)
                              : const Color(0xFF457B9D);
                          borderColor = isSelected
                              ? const Color(0xFFFFD60A)
                              : Colors.transparent;
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: GestureDetector(
                            onTap: hasAnswered 
                                ? null 
                                : () => controller.selectAnswer(index),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: borderColor,
                                  width: 3,
                                ),
                                boxShadow: [
                                  if (isSelected && !hasAnswered)
                                    BoxShadow(
                                      color: const Color(0xFFFFD60A).withOpacity(0.5),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  // Lettre (A, B, C, D)
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: hasAnswered
                                          ? Colors.white.withOpacity(0.3)
                                          : Colors.black.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        String.fromCharCode(65 + index), // A, B, C, D
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFF1FAEE),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  
                                  // Texte de la réponse
                                  Expanded(
                                    child: Text(
                                      question.options[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: hasAnswered && !isCorrect && !isSelected
                                            ? const Color(0xFFA8DADC)
                                            : const Color(0xFFF1FAEE),
                                      ),
                                    ),
                                  ),

                                  // Icône de résultat
                                  if (hasAnswered)
                                    Icon(
                                      isCorrect ? Icons.check_circle : 
                                      (isSelected ? Icons.cancel : Icons.circle_outlined),
                                      color: isCorrect 
                                          ? Colors.white 
                                          : (isSelected ? Colors.white : Colors.transparent),
                                      size: 28,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Bouton Suivant (apparaît après avoir répondu)
                  if (controller.hasAnswered.value)
                    ElevatedButton(
                      onPressed: controller.nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD60A),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        controller.currentQuestionIndex.value < controller.questions.length - 1
                            ? 'QUESTION SUIVANTE'
                            : 'VOIR LES RÉSULTATS',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}