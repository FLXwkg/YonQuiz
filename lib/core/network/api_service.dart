import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../features/learn/data/models/character_model.dart';
import '../../features/learn/data/models/fruit_model.dart';

class ApiService {
  static const String baseUrl = 'https://api.api-onepiece.com/v2';

  // Récupérer tous les personnages
  Future<List<CharacterModel>> getCharacters() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/characters/en'),
      );

      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => CharacterModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // Récupérer tous les fruits
  Future<List<FruitModel>> getFruits() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/fruits/en'),
      );

      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => FruitModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load fruits: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // Récupérer un personnage par ID
  Future<CharacterModel> getCharacterById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/characters/en/$id'),
      );

      if (response.statusCode == 200) {
        return CharacterModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load character: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  // Récupérer un fruit par ID
  Future<FruitModel> getFruitById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/fruits/en/$id'),
      );

      if (response.statusCode == 200) {
        return FruitModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load fruit: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}