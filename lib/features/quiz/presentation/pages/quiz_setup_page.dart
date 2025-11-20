import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/quiz_type_model.dart';
import '../controllers/quiz_controller.dart';

class QuizSetupPage extends StatelessWidget {
  const QuizSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuizController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎮 Configuration du Quiz'),
        backgroundColor: const Color(0xFFE63946),
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
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Choisis ton mode de jeu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF1FAEE),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Type de quiz
                Expanded(
                  child: ListView.builder(
                    itemCount: QuizType.values.length,
                    itemBuilder: (context, index) {
                      final type = QuizType.values[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Obx(() => GestureDetector(
                          onTap: () => controller.selectedQuizType.value = type,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: controller.selectedQuizType == type
                                  ? const Color(0xFFE63946)
                                  : const Color(0xFF457B9D),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: controller.selectedQuizType.value == type
                                    ? const Color(0xFFFFD60A)
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  type.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF1FAEE),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  type.description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFA8DADC),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                      );
                    },
                  ),
                ),

                // Nombre de questions
                const SizedBox(height: 20),
                const Text(
                  'Nombre de questions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF1FAEE),
                  ),
                ),
                const SizedBox(height: 10),
                Obx(() => Slider(
                  value: controller.numberOfQuestions.value.toDouble(),
                  min: 5,
                  max: 20,
                  divisions: 15,
                  activeColor: const Color(0xFFFFD60A),
                  inactiveColor: const Color(0xFF457B9D),
                  label: controller.numberOfQuestions.value.toString(),
                  onChanged: (value) {
                    controller.numberOfQuestions.value = value.toInt();
                  },
                )),
                Center(
                  child: Obx(() => Text(
                    '${controller.numberOfQuestions.value} questions',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFF1FAEE),
                    ),
                  ),
                )),

                const SizedBox(height: 30),

                // Bouton Commencer
                ElevatedButton(
                  onPressed: () async {
                    await controller.generateQuestions();
                    if (controller.questions.isNotEmpty) {
                      Get.toNamed('/quiz/game');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD60A),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'COMMENCER',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}