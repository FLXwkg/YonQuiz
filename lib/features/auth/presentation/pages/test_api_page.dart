import 'package:flutter/material.dart';
import '../../../../core/network/api_service.dart';
import '../../../learn/data/models/character_model.dart';
import '../../../learn/data/models/fruit_model.dart';

class TestApiPage extends StatefulWidget {
  const TestApiPage({super.key});

  @override
  State<TestApiPage> createState() => _TestApiPageState();
}

class _TestApiPageState extends State<TestApiPage> {
  final ApiService _apiService = ApiService();
  String _result = 'Appuie sur un bouton pour tester l\'API 🏴‍☠️';
  bool _loading = false;

  Future<void> _testCharacters() async {
    setState(() {
      _loading = true;
      _result = 'Chargement des personnages...';
    });

    try {
      final List<CharacterModel> characters = await _apiService.getCharacters();
      
      String displayText = '🏴‍☠️ PERSONNAGES ONE PIECE\n';
      displayText += '=' * 40 + '\n';
      displayText += 'Total: ${characters.length} personnages\n\n';
      
      // Affiche les 10 premiers
      for (var i = 0; i < (characters.length > 10 ? 10 : characters.length); i++) {
        final char = characters[i];
        displayText += '${i + 1}. ${char.name ?? "Inconnu"}\n';
        displayText += '   📏 Taille: ${char.size ?? "?"}\n';
        displayText += '   🎂 Age: ${char.age ?? "?"}\n';
        displayText += '   💰 Prime: ${char.bounty ?? "Aucune"}\n';
        displayText += '   ⚓ Crew: ${char.crew?.name ?? "Aucun"}\n';
        displayText += '   🍎 Fruit: ${char.fruit?.name ?? "Aucun"}\n';
        displayText += '   💼 Job: ${char.job ?? "?"}\n';
        displayText += '   ❤️ Status: ${char.status ?? "?"}\n';
        displayText += '\n';
      }
      
      displayText += '\n✅ Chargement réussi !';
      
      setState(() {
        _result = displayText;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _result = '❌ Erreur lors du chargement des personnages:\n\n$e';
        _loading = false;
      });
    }
  }

  Future<void> _testFruits() async {
    setState(() {
      _loading = true;
      _result = 'Chargement des fruits du démon...';
    });

    try {
      final List<FruitModel> fruits = await _apiService.getFruits();
      
      String displayText = '🍎 FRUITS DU DÉMON\n';
      displayText += '=' * 40 + '\n';
      displayText += 'Total: ${fruits.length} fruits\n\n';
      
      // Affiche les 10 premiers
      for (var i = 0; i < (fruits.length > 10 ? 10 : fruits.length); i++) {
        final fruit = fruits[i];
        displayText += '${i + 1}. ${fruit.name ?? "Inconnu"}\n';
        displayText += '   📝 Type: ${fruit.type ?? "?"}\n';
        displayText += '   🇯🇵 Nom JP: ${fruit.romanName ?? "?"}\n';
        displayText += '   📖 Description: ${fruit.description?.substring(0, fruit.description!.length > 80 ? 80 : fruit.description!.length) ?? "?"}...\n';
        displayText += '\n';
      }
      
      displayText += '\n✅ Chargement réussi !';
      
      setState(() {
        _result = displayText;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _result = '❌ Erreur lors du chargement des fruits:\n\n$e';
        _loading = false;
      });
    }
  }

  Future<void> _testCharacterById() async {
    setState(() {
      _loading = true;
      _result = 'Chargement de Luffy...';
    });

    try {
      final CharacterModel luffy = await _apiService.getCharacterById(1);
      
      String displayText = '👑 MONKEY D. LUFFY\n';
      displayText += '=' * 40 + '\n\n';
      displayText += '📋 INFORMATIONS GÉNÉRALES\n';
      displayText += '   ID: ${luffy.id}\n';
      displayText += '   Nom: ${luffy.name}\n';
      displayText += '   Age: ${luffy.age}\n';
      displayText += '   Taille: ${luffy.size}\n';
      displayText += '   Prime: ${luffy.bounty}\n';
      displayText += '   Job: ${luffy.job}\n';
      displayText += '   Status: ${luffy.status}\n\n';
      
      displayText += '⚓ ÉQUIPAGE\n';
      displayText += '   Nom: ${luffy.crew?.name ?? "Aucun"}\n';
      displayText += '   Membres: ${luffy.crew?.number ?? "?"}\n';
      displayText += '   Prime totale: ${luffy.crew?.totalPrime ?? "?"}\n';
      displayText += '   Yonko: ${luffy.crew?.isYonko == true ? "Oui ⭐" : "Non"}\n\n';
      
      displayText += '🍎 FRUIT DU DÉMON\n';
      displayText += '   Nom: ${luffy.fruit?.name ?? "Aucun"}\n';
      displayText += '   Type: ${luffy.fruit?.type ?? "?"}\n';
      displayText += '   Nom JP: ${luffy.fruit?.romanName ?? "?"}\n\n';
      
      displayText += '✅ Détails complets chargés !';
      
      setState(() {
        _result = displayText;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _result = '❌ Erreur lors du chargement de Luffy:\n\n$e';
        _loading = false;
      });
    }
  }

  Future<void> _testFruitById() async {
    setState(() {
      _loading = true;
      _result = 'Chargement du Gomu Gomu no Mi...';
    });

    try {
      final FruitModel fruit = await _apiService.getFruitById(1);
      
      String displayText = '🍎 GOMU GOMU NO MI\n';
      displayText += '=' * 40 + '\n\n';
      displayText += '   ID: ${fruit.id}\n';
      displayText += '   Nom: ${fruit.name}\n';
      displayText += '   Type: ${fruit.type}\n';
      displayText += '   Nom JP: ${fruit.romanName}\n\n';
      displayText += '📖 DESCRIPTION:\n';
      displayText += '${fruit.description}\n\n';
      displayText += '🖼️ Image: ${fruit.filename}\n\n';
      displayText += '✅ Détails complets chargés !';
      
      setState(() {
        _result = displayText;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _result = '❌ Erreur lors du chargement du fruit:\n\n$e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🏴‍☠️ Test API One Piece'),
        backgroundColor: const Color(0xFFE63946),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1D3557),
              Color(0xFF457B9D),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Boutons principaux
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _loading ? null : _testCharacters,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE63946),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.people),
                      label: const Text('Characters'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _loading ? null : _testFruits,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD60A),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.apple),
                      label: const Text('Fruits'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Boutons détails
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _loading ? null : _testCharacterById,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF457B9D),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.person),
                      label: const Text('Luffy'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _loading ? null : _testFruitById,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF06D6A0),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.eco),
                      label: const Text('Gomu Gomu'),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Loading indicator
              if (_loading)
                const Column(
                  children: [
                    CircularProgressIndicator(
                      color: Color(0xFFFFD60A),
                      strokeWidth: 4,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Chargement en cours...',
                      style: TextStyle(
                        color: Color(0xFFF1FAEE),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              
              const SizedBox(height: 20),
              
              // Résultat
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D3557),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFE63946),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _result,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        color: Color(0xFFF1FAEE),
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}