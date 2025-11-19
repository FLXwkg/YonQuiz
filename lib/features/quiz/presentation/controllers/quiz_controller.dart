import 'package:get/get.dart';
import '../../../../core/network/api_service.dart';
import '../../../learn/data/models/character_model.dart';
import '../../data/models/quiz_question_model.dart';
import '../../data/models/quiz_type_model.dart';

class QuizController extends GetxController {
  final ApiService _apiService = ApiService();

  // State
  var isLoading = false.obs;
  var currentQuestionIndex = 0.obs;
  var score = 0.obs;
  var questions = <QuizQuestion>[].obs;
  var selectedAnswerIndex = Rx<int?>(null);
  var hasAnswered = false.obs;

  // Config
  int numberOfQuestions = 10;
  QuizType selectedQuizType = QuizType.nameToFruit;

  // Générer les questions
  Future<void> generateQuestions() async {
    try {
      isLoading.value = true;
      questions.clear();
      
      print('🎮 [Quiz] Chargement des personnages...');
      final characters = await _apiService.getCharacters();
      
      // Filtre les personnages qui ont un fruit
      final charactersWithFruit = characters
          .where((c) => c.fruit != null && c.fruit!.name != null)
          .toList();

      print('🎮 [Quiz] ${charactersWithFruit.length} personnages avec fruits');

      if (charactersWithFruit.length < 4) {
        throw Exception('Pas assez de personnages avec fruits');
      }

      // Mélange et prend les N premiers
      charactersWithFruit.shuffle();
      final selectedChars = charactersWithFruit.take(numberOfQuestions).toList();

      // Génère les questions selon le type
      for (var char in selectedChars) {
        final question = _generateQuestion(char, charactersWithFruit);
        questions.add(question);
      }

      print('✅ [Quiz] ${questions.length} questions générées');
      isLoading.value = false;
    } catch (e) {
      print('❌ [Quiz] Erreur: $e');
      isLoading.value = false;
      Get.snackbar(
        'Erreur',
        'Impossible de charger les questions: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Générer une question selon le type
  QuizQuestion _generateQuestion(
    CharacterModel character,
    List<CharacterModel> allCharacters,
  ) {
    switch (selectedQuizType) {
      case QuizType.nameToFruit:
        return _generateNameToFruitQuestion(character, allCharacters);
      case QuizType.fruitToName:
        return _generateFruitToNameQuestion(character, allCharacters);
      case QuizType.nameToCrew:
        return _generateNameToCrewQuestion(character, allCharacters);
      case QuizType.nameToSize:
        return _generateNameToSizeQuestion(character, allCharacters);
    }
  }

  // Question : Nom → Fruit
  QuizQuestion _generateNameToFruitQuestion(
    CharacterModel character,
    List<CharacterModel> allCharacters,
  ) {
    final correctAnswer = character.fruit!.name!;
    
    // Génère 3 mauvaises réponses
    final wrongAnswers = allCharacters
        .where((c) => 
            c.fruit != null && 
            c.fruit!.name != null && 
            c.fruit!.name != correctAnswer)
        .map((c) => c.fruit!.name!)
        .toSet()
        .take(3)
        .toList();

    final options = [...wrongAnswers, correctAnswer];
    options.shuffle();

    return QuizQuestion(
      question: 'Quel est le fruit du démon de ${character.name} ?',
      options: options,
      correctAnswerIndex: options.indexOf(correctAnswer),
      type: QuizType.nameToFruit,
    );
  }

  // Question : Fruit → Nom
  QuizQuestion _generateFruitToNameQuestion(
    CharacterModel character,
    List<CharacterModel> allCharacters,
  ) {
    final correctAnswer = character.name!;
    
    // Génère 3 mauvaises réponses
    final wrongAnswers = allCharacters
        .where((c) => c.name != null && c.name != correctAnswer)
        .map((c) => c.name!)
        .toSet()
        .take(3)
        .toList();

    final options = [...wrongAnswers, correctAnswer];
    options.shuffle();

    return QuizQuestion(
      question: 'Qui possède le ${character.fruit!.name} ?',
      options: options,
      correctAnswerIndex: options.indexOf(correctAnswer),
      type: QuizType.fruitToName,
    );
  }

  // Question : Nom → Crew
  QuizQuestion _generateNameToCrewQuestion(
    CharacterModel character,
    List<CharacterModel> allCharacters,
  ) {
    final correctAnswer = character.crew?.name ?? 'Aucun équipage';
    
    final wrongAnswers = allCharacters
        .where((c) => 
            c.crew != null && 
            c.crew!.name != null && 
            c.crew!.name != correctAnswer)
        .map((c) => c.crew!.name!)
        .toSet()
        .take(3)
        .toList();

    final options = [...wrongAnswers, correctAnswer];
    options.shuffle();

    return QuizQuestion(
      question: 'Dans quel équipage est ${character.name} ?',
      options: options,
      correctAnswerIndex: options.indexOf(correctAnswer),
      type: QuizType.nameToCrew,
    );
  }

  // Question : Nom → Taille
  QuizQuestion _generateNameToSizeQuestion(
    CharacterModel character,
    List<CharacterModel> allCharacters,
  ) {
    final correctAnswer = character.size ?? 'Inconnue';
    
    final wrongAnswers = allCharacters
        .where((c) => 
            c.size != null && 
            c.size != correctAnswer)
        .map((c) => c.size!)
        .toSet()
        .take(3)
        .toList();

    final options = [...wrongAnswers, correctAnswer];
    options.shuffle();

    return QuizQuestion(
      question: 'Quelle est la taille de ${character.name} ?',
      options: options,
      correctAnswerIndex: options.indexOf(correctAnswer),
      type: QuizType.nameToSize,
    );
  }

  // Sélectionner une réponse
  void selectAnswer(int index) {
    if (hasAnswered.value) return;
    
    selectedAnswerIndex.value = index;
    hasAnswered.value = true;

    // Vérifie si c'est correct
    if (index == questions[currentQuestionIndex.value].correctAnswerIndex) {
      score.value++;
      print('✅ Bonne réponse ! Score: ${score.value}');
    } else {
      print('❌ Mauvaise réponse !');
    }
  }

  // Question suivante
  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      selectedAnswerIndex.value = null;
      hasAnswered.value = false;
    } else {
      // Fin du quiz
      Get.toNamed('/quiz/result');
    }
  }

  // Recommencer
  void restart() {
    currentQuestionIndex.value = 0;
    score.value = 0;
    selectedAnswerIndex.value = null;
    hasAnswered.value = false;
    generateQuestions();
  }

  // Reset pour retour au menu
  void reset() {
    currentQuestionIndex.value = 0;
    score.value = 0;
    selectedAnswerIndex.value = null;
    hasAnswered.value = false;
    questions.clear();
  }
}