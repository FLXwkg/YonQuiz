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
  var preselectedAnswerIndex = Rx<int?>(null);
  var selectedAnswerIndex = Rx<int?>(null);
  var hasAnswered = false.obs;

  // Config
  var numberOfQuestions = 10.obs; 
  var selectedQuizType = QuizType.nameToFruit.obs;

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
      final selectedChars = charactersWithFruit.take(numberOfQuestions.value).toList(); // ✅ .value

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
    switch (selectedQuizType.value) { // ✅ .value
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
    
    // Récupère TOUS les fruits différents du bon
    final allWrongAnswers = allCharacters
        .where((c) => 
            c.fruit != null && 
            c.fruit!.name != null && 
            c.fruit!.name != correctAnswer)
        .map((c) => c.fruit!.name!)
        .toSet() // Évite les doublons
        .toList();

    // Mélange et prend 3 au hasard
    allWrongAnswers.shuffle();
    final wrongAnswers = allWrongAnswers.take(3).toList();

    // Crée les options et les mélange
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
    
    // Récupère TOUS les noms différents du bon
    final allWrongAnswers = allCharacters
        .where((c) => c.name != null && c.name != correctAnswer)
        .map((c) => c.name!)
        .toSet()
        .toList();

    // Mélange et prend 3 au hasard
    allWrongAnswers.shuffle();
    final wrongAnswers = allWrongAnswers.take(3).toList();

    // Crée les options et les mélange
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
    
    // Récupère TOUS les équipages différents du bon
    final allWrongAnswers = allCharacters
        .where((c) => 
            c.crew != null && 
            c.crew!.name != null && 
            c.crew!.name != correctAnswer)
        .map((c) => c.crew!.name!)
        .toSet()
        .toList();

    // Mélange et prend 3 au hasard
    allWrongAnswers.shuffle();
    final wrongAnswers = allWrongAnswers.take(3).toList();

    // Si pas assez d'équipages, ajoute des options génériques
    while (wrongAnswers.length < 3) {
      final genericOptions = [
        'Pirates du Soleil',
        'Pirates aux cent bêtes',
        'Baroque Works',
        'CP9',
        'Marines',
        'Aucun équipage'
      ];
      genericOptions.shuffle();
      for (var option in genericOptions) {
        if (!wrongAnswers.contains(option) && option != correctAnswer) {
          wrongAnswers.add(option);
          if (wrongAnswers.length >= 3) break;
        }
      }
    }

    // Crée les options et les mélange
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
    
    // Récupère TOUTES les tailles différentes de la bonne
    final allWrongAnswers = allCharacters
        .where((c) => 
            c.size != null && 
            c.size != correctAnswer)
        .map((c) => c.size!)
        .toSet()
        .toList();

    // Mélange et prend 3 au hasard
    allWrongAnswers.shuffle();
    final wrongAnswers = allWrongAnswers.take(3).toList();

    // Si pas assez de tailles, génère des tailles aléatoires proches
    if (wrongAnswers.length < 3) {
      final correctSize = int.tryParse(correctAnswer.replaceAll(RegExp(r'[^0-9]'), ''));
      if (correctSize != null) {
        while (wrongAnswers.length < 3) {
          final offset = [10, 20, 30, -10, -20, -30][wrongAnswers.length];
          final fakeSize = '${correctSize + offset}cm';
          if (!wrongAnswers.contains(fakeSize) && fakeSize != correctAnswer) {
            wrongAnswers.add(fakeSize);
          }
        }
      }
    }

    // Crée les options et les mélange
    final options = [...wrongAnswers, correctAnswer];
    options.shuffle();

    return QuizQuestion(
      question: 'Quelle est la taille de ${character.name} ?',
      options: options,
      correctAnswerIndex: options.indexOf(correctAnswer),
      type: QuizType.nameToSize,
    );
  }

  void preselectAnswer(int index) {
    if (hasAnswered.value) return;
    preselectedAnswerIndex.value = index;
    print('🟡 Réponse présélectionnée: $index');
  }

  // ✅ NOUVELLE MÉTHODE : Valider la réponse présélectionnée
  void validateAnswer() {
    if (hasAnswered.value || preselectedAnswerIndex.value == null) return;
    
    selectedAnswerIndex.value = preselectedAnswerIndex.value;
    hasAnswered.value = true;

    // Vérifie si c'est correct
    if (selectedAnswerIndex.value == questions[currentQuestionIndex.value].correctAnswerIndex) {
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
      preselectedAnswerIndex.value = null; // ✅ Reset présélection
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
    preselectedAnswerIndex.value = null; // ✅ Reset présélection
    selectedAnswerIndex.value = null;
    hasAnswered.value = false;
    generateQuestions();
  }

  // Reset pour retour au menu
  void reset() {
    currentQuestionIndex.value = 0;
    score.value = 0;
    preselectedAnswerIndex.value = null; // ✅ Reset présélection
    selectedAnswerIndex.value = null;
    hasAnswered.value = false;
    questions.clear();
  }
}