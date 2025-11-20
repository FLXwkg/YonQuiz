import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yon_quiz/core/routes/app_routes.dart';
import '../controllers/learn_controller.dart';

class CharactersListPage extends StatelessWidget {
  const CharactersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LearnController());

    // Charger les personnages au démarrage
    controller.loadCharacters();

    return Scaffold(
      appBar: AppBar(
        title: const Text('👤 Personnages'),
        backgroundColor: const Color(0xFFE63946),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1D3557), Color(0xFF457B9D)],
          ),
        ),
        child: Column(
          children: [
            // Barre de recherche
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) => controller.searchQuery.value = value,
                style: const TextStyle(color: Color(0xFFF1FAEE)),
                decoration: InputDecoration(
                  hintText: 'Rechercher un personnage...',
                  hintStyle: const TextStyle(color: Color(0xFFA8DADC)),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFFFD60A)),
                  suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Color(0xFFA8DADC)),
                          onPressed: controller.clearSearch,
                        )
                      : const SizedBox.shrink()),
                  filled: true,
                  fillColor: const Color(0xFF1D3557),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFFE63946), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFFE63946), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFFFFD60A), width: 2),
                  ),
                ),
              ),
            ),

            // Liste des personnages
            Expanded(
              child: Obx(() {
                if (controller.isLoadingCharacters.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFFFD60A),
                    ),
                  );
                }

                final characters = controller.filteredCharacters;

                if (characters.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: const Color(0xFFA8DADC).withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          controller.searchQuery.value.isEmpty
                              ? 'Aucun personnage disponible'
                              : 'Aucun résultat trouvé',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color(0xFFA8DADC),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    final character = characters[index];
                    return _CharacterCard(character: character);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget pour afficher une carte de personnage
class _CharacterCard extends StatelessWidget {
  final dynamic character;

  const _CharacterCard({required this.character});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector( // ✅ AJOUT : Wrapper avec GestureDetector
      onTap: () {
        // ✅ AJOUT : Navigation vers détail
        Get.toNamed(
          AppRoutes.detail,
          arguments: {'type': 'character', 'data': character},
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1D3557),
          borderRadius: BorderRadius.circular(16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nom du personnage
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: Color(0xFFFFD60A),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    character.name ?? 'Inconnu',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF1FAEE),
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFA8DADC),
                  size: 20,
                ),
              ],
            ),

            const Divider(color: Color(0xFF457B9D), height: 24),

            // Infos
            _InfoRow(
              icon: Icons.cake,
              label: 'Âge',
              value: character.age ?? 'Inconnu',
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.height,
              label: 'Taille',
              value: character.size ?? 'Inconnue',
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.monetization_on,
              label: 'Prime',
              value: character.bounty ?? 'Aucune',
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.work,
              label: 'Poste',
              value: character.job ?? 'Inconnu',
            ),
            const SizedBox(height: 8),
            _InfoRow(
              icon: Icons.group,
              label: 'Équipage',
              value: character.crew?.name ?? 'Aucun',
            ),

            // Fruit du démon
            if (character.fruit != null) ...[
              const Divider(color: Color(0xFF457B9D), height: 24),
              Row(
                children: [
                  if (character.fruit!.filename != null && character.fruit!.filename!.isNotEmpty)
                    Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF06D6A0),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          character.fruit!.filename!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xFF457B9D),
                              child: const Icon(
                                Icons.eco,
                                color: Color(0xFF06D6A0),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Fruit du Démon',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFFA8DADC),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          character.fruit!.name ?? 'Inconnu',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF06D6A0),
                          ),
                        ),
                        Text(
                          'Type: ${character.fruit!.type ?? "?"}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFA8DADC),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      )
    );
  }
}

// Widget pour une ligne d'info
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: const Color(0xFFFFD60A),
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFFA8DADC),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF1FAEE),
            ),
          ),
        ),
      ],
    );
  }
}