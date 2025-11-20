import 'package:get/get.dart';
import '../../../../core/network/api_service.dart';
import '../../data/models/character_model.dart';
import '../../data/models/fruit_model.dart';

class LearnController extends GetxController {
  final ApiService _apiService = ApiService();

  // State
  var isLoadingCharacters = false.obs;
  var isLoadingFruits = false.obs;
  var characters = <CharacterModel>[].obs;
  var fruits = <FruitModel>[].obs;

  // Recherche
  var searchQuery = ''.obs;

  // Filtrer les personnages selon la recherche
  List<CharacterModel> get filteredCharacters {
    if (searchQuery.value.isEmpty) {
      return characters;
    }
    return characters.where((char) {
      final name = char.name?.toLowerCase() ?? '';
      final query = searchQuery.value.toLowerCase();
      return name.contains(query);
    }).toList();
  }

  // Filtrer les fruits selon la recherche
  List<FruitModel> get filteredFruits {
    if (searchQuery.value.isEmpty) {
      return fruits;
    }
    return fruits.where((fruit) {
      final name = fruit.name?.toLowerCase() ?? '';
      final query = searchQuery.value.toLowerCase();
      return name.contains(query);
    }).toList();
  }

  // Charger les personnages
  Future<void> loadCharacters() async {
    if (characters.isNotEmpty) return; // Déjà chargés

    try {
      isLoadingCharacters.value = true;
      print('📚 [Learn] Chargement des personnages...');
      
      final data = await _apiService.getCharacters();
      characters.assignAll(data);
      
      print('✅ [Learn] ${characters.length} personnages chargés');
      isLoadingCharacters.value = false;
    } catch (e) {
      print('❌ [Learn] Erreur personnages: $e');
      isLoadingCharacters.value = false;
      Get.snackbar(
        'Erreur',
        'Impossible de charger les personnages',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Charger les fruits
  Future<void> loadFruits() async {
    if (fruits.isNotEmpty) return; // Déjà chargés

    try {
      isLoadingFruits.value = true;
      print('📚 [Learn] Chargement des fruits...');
      
      final data = await _apiService.getFruits();
      fruits.assignAll(data);
      
      print('✅ [Learn] ${fruits.length} fruits chargés');
      isLoadingFruits.value = false;
    } catch (e) {
      print('❌ [Learn] Erreur fruits: $e');
      isLoadingFruits.value = false;
      Get.snackbar(
        'Erreur',
        'Impossible de charger les fruits',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Reset recherche
  void clearSearch() {
    searchQuery.value = '';
  }
}