import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../features/learn/data/models/character_model.dart';
import '../../features/learn/data/models/fruit_model.dart';

class ApiService {
  static const String baseUrl = 'https://api.api-onepiece.com/v2';

  // Récupérer tous les personnages
  Future<List<CharacterModel>> getCharacters() async {
    print('🔵 [API] Début getCharacters');
    try {
      final url = Uri.parse('$baseUrl/characters/en');
      print('🔵 [API] URL: $url');
      
      final request = http.Request('GET', url);
      request.headers.addAll({
        'User-Agent': 'YonQuiz/1.0',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
      });

      print('🔵 [API] Sending request...');
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print('⏰ [API] Request timeout!');
          throw TimeoutException('Request timeout');
        },
      );
      
      print('🔵 [API] Got streamed response: ${streamedResponse.statusCode}');
      final response = await http.Response.fromStream(streamedResponse);
      print('🔵 [API] Response converted, body length: ${response.body.length}');

      if (response.statusCode == 200) {
        print('🔵 [API] Parsing JSON...');
        final List<dynamic> data = json.decode(response.body);
        print('🔵 [API] Found ${data.length} characters');
        
        final characters = data.map((json) => CharacterModel.fromJson(json)).toList();
        print('✅ [API] Characters parsed successfully');
        return characters;
      } else {
        print('❌ [API] Error status: ${response.statusCode}');
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('❌ [API] Timeout: $e');
      rethrow;
    } on SocketException catch (e) {
      print('❌ [API] Socket Exception: $e');
      rethrow;
    } catch (e) {
      print('❌ [API] Exception: $e');
      rethrow;
    }
  }

  // Récupérer tous les fruits
  Future<List<FruitModel>> getFruits() async {
    print('🔵 [API] Début getFruits');
    try {
      final url = Uri.parse('$baseUrl/fruits/en');
      print('🔵 [API] URL: $url');
      
      final request = http.Request('GET', url);
      request.headers.addAll({
        'User-Agent': 'YonQuiz/1.0',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
      });

      print('🔵 [API] Sending request...');
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print('⏰ [API] Request timeout!');
          throw TimeoutException('Request timeout');
        },
      );
      
      print('🔵 [API] Got streamed response: ${streamedResponse.statusCode}');
      final response = await http.Response.fromStream(streamedResponse);
      print('🔵 [API] Response converted, body length: ${response.body.length}');

      if (response.statusCode == 200) {
        print('🔵 [API] Parsing JSON...');
        final List<dynamic> data = json.decode(response.body);
        print('🔵 [API] Found ${data.length} fruits');
        
        final fruits = data.map((json) => FruitModel.fromJson(json)).toList();
        print('✅ [API] Fruits parsed successfully');
        return fruits;
      } else {
        print('❌ [API] Error status: ${response.statusCode}');
        throw Exception('Failed to load fruits: ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('❌ [API] Timeout: $e');
      rethrow;
    } on SocketException catch (e) {
      print('❌ [API] Socket Exception: $e');
      rethrow;
    } catch (e) {
      print('❌ [API] Exception: $e');
      rethrow;
    }
  }

  // Récupérer un personnage par ID
  Future<CharacterModel> getCharacterById(int id) async {
    print('🔵 [API] Début getCharacterById: $id');
    try {
      final url = Uri.parse('$baseUrl/characters/en/$id');
      print('🔵 [API] URL: $url');
      
      final request = http.Request('GET', url);
      request.headers.addAll({
        'User-Agent': 'YonQuiz/1.0',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
      });

      print('🔵 [API] Sending request...');
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print('⏰ [API] Request timeout!');
          throw TimeoutException('Request timeout');
        },
      );
      
      print('🔵 [API] Got streamed response: ${streamedResponse.statusCode}');
      final response = await http.Response.fromStream(streamedResponse);
      print('🔵 [API] Response converted');

      if (response.statusCode == 200) {
        print('🔵 [API] Parsing character...');
        final character = CharacterModel.fromJson(json.decode(response.body));
        print('✅ [API] Character parsed: ${character.name}');
        return character;
      } else {
        print('❌ [API] Error status: ${response.statusCode}');
        throw Exception('Failed to load character: ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('❌ [API] Timeout: $e');
      rethrow;
    } on SocketException catch (e) {
      print('❌ [API] Socket Exception: $e');
      rethrow;
    } catch (e) {
      print('❌ [API] Exception: $e');
      rethrow;
    }
  }

  // Récupérer un fruit par ID
  Future<FruitModel> getFruitById(int id) async {
    print('🔵 [API] Début getFruitById: $id');
    try {
      final url = Uri.parse('$baseUrl/fruits/en/$id');
      print('🔵 [API] URL: $url');
      
      final request = http.Request('GET', url);
      request.headers.addAll({
        'User-Agent': 'YonQuiz/1.0',
        'Accept': 'application/json',
        'Connection': 'keep-alive',
      });

      print('🔵 [API] Sending request...');
      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          print('⏰ [API] Request timeout!');
          throw TimeoutException('Request timeout');
        },
      );
      
      print('🔵 [API] Got streamed response: ${streamedResponse.statusCode}');
      final response = await http.Response.fromStream(streamedResponse);
      print('🔵 [API] Response converted');

      if (response.statusCode == 200) {
        print('🔵 [API] Parsing fruit...');
        final fruit = FruitModel.fromJson(json.decode(response.body));
        print('✅ [API] Fruit parsed: ${fruit.name}');
        return fruit;
      } else {
        print('❌ [API] Error status: ${response.statusCode}');
        throw Exception('Failed to load fruit: ${response.statusCode}');
      }
    } on TimeoutException catch (e) {
      print('❌ [API] Timeout: $e');
      rethrow;
    } on SocketException catch (e) {
      print('❌ [API] Socket Exception: $e');
      rethrow;
    } catch (e) {
      print('❌ [API] Exception: $e');
      rethrow;
    }
  }
}