import 'package:yon_quiz/features/quiz/data/models/quiz_type_model.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final QuizType type;
  final List<String?> optionImages; // ✅ Ajout images des options
  final String? questionImage;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.type,
    this.optionImages = const [],
    this.questionImage,
  });

  String get correctAnswer => options[correctAnswerIndex];
}