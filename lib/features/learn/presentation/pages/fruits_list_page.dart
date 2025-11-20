import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yon_quiz/core/routes/app_routes.dart';
import '../controllers/learn_controller.dart';

class FruitsListPage extends StatelessWidget {
  const FruitsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LearnController());

    // Charger les fruits au démarrage
    controller.loadFruits();

    return Scaffold(
      appBar: AppBar(
        title: const Text('🍎 Fruits du Démon'),
        backgroundColor: const Color(0xFF06D6A0),
        centerTitle: true,
        actions: [
          // Bouton reset filtres
          Obx(() {
            if (controller.searchQuery.value.isNotEmpty || 
                controller.selectedFruitType.value != null) {
              return IconButton(
                icon: const Icon(Icons.filter_alt_off),
                onPressed: controller.clearAllFilters,
                tooltip: 'Réinitialiser les filtres',
              );
            }
            return const SizedBox.shrink();
          }),
        ],
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
                  hintText: 'Rechercher un fruit...',
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
                    borderSide: const BorderSide(color: Color(0xFF06D6A0), width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFF06D6A0), width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: Color(0xFFFFD60A), width: 2),
                  ),
                ),
              ),
            ),

            // Filtres par type ✅ AJOUT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _TypeChip(
                      label: 'Tous',
                      isSelected: controller.selectedFruitType.value == null,
                      color: const Color(0xFF457B9D),
                      onTap: () => controller.selectedFruitType.value = null,
                    ),
                    const SizedBox(width: 8),
                    _TypeChip(
                      label: 'Paramecia',
                      isSelected: controller.selectedFruitType.value == 'Paramecia',
                      color: const Color(0xFFE63946),
                      onTap: () => controller.selectedFruitType.value = 'Paramecia',
                    ),
                    const SizedBox(width: 8),
                    _TypeChip(
                      label: 'Zoan',
                      isSelected: controller.selectedFruitType.value == 'Zoan',
                      color: const Color(0xFFFFD60A),
                      onTap: () => controller.selectedFruitType.value = 'Zoan',
                    ),
                    const SizedBox(width: 8),
                    _TypeChip(
                      label: 'Logia',
                      isSelected: controller.selectedFruitType.value == 'Logia',
                      color: const Color(0xFF06D6A0),
                      onTap: () => controller.selectedFruitType.value = 'Logia',
                    ),
                  ],
                ),
              )),
            ),

            const SizedBox(height: 16),

            // Liste des fruits
            Expanded(
              child: Obx(() {
                if (controller.isLoadingFruits.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFFFD60A),
                    ),
                  );
                }

                final fruits = controller.filteredFruits;

                if (fruits.isEmpty) {
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
                          'Aucun résultat trouvé',
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
                  itemCount: fruits.length,
                  itemBuilder: (context, index) {
                    final fruit = fruits[index];
                    return _FruitCard(
                      fruit: fruit,
                      onTap: () {
                        // ✅ Navigation vers détail
                        Get.toNamed(
                          AppRoutes.detail,
                          arguments: {'type': 'fruit', 'data': fruit},
                        );
                      },
                    );
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

// Widget chip pour les filtres de type ✅ NOUVEAU
class _TypeChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _TypeChip({
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? color : const Color(0xFF1D3557),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: color,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isSelected 
                ? Colors.white 
                : color,
          ),
        ),
      ),
    );
  }
}

// Widget pour afficher une carte de fruit
class _FruitCard extends StatelessWidget {
  final dynamic fruit;
  final VoidCallback onTap; // ✅ AJOUT

  const _FruitCard({
    required this.fruit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // ✅ AJOUT
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1D3557),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF06D6A0),
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
            // Header avec image et nom
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image du fruit
                if (fruit.filename != null && fruit.filename!.isNotEmpty)
                  Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFFD60A),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        fruit.filename!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: const Color(0xFF457B9D),
                            child: const Center(
                              child: Icon(
                                Icons.eco,
                                color: Color(0xFF06D6A0),
                                size: 40,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                else
                  Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF457B9D),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFFD60A),
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.eco,
                        color: Color(0xFF06D6A0),
                        size: 40,
                      ),
                    ),
                  ),

                // Nom et type
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fruit.name ?? 'Inconnu',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF1FAEE),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getTypeColor(fruit.type),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          fruit.type ?? 'Type inconnu',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF1FAEE),
                          ),
                        ),
                      ),
                      if (fruit.romanName != null && fruit.romanName!.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          fruit.romanName!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFFA8DADC),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                // Icône pour indiquer qu'on peut cliquer ✅ AJOUT
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFFA8DADC),
                  size: 20,
                ),
              ],
            ),

            // Description (tronquée)
            if (fruit.description != null && fruit.description!.isNotEmpty) ...[
              const Divider(color: Color(0xFF457B9D), height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.description,
                    size: 18,
                    color: Color(0xFFFFD60A),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      fruit.description!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFF1FAEE),
                        height: 1.4,
                      ),
                      maxLines: 3, // ✅ Limité à 3 lignes
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Couleur selon le type de fruit
  Color _getTypeColor(String? type) {
    switch (type?.toLowerCase()) {
      case 'paramecia':
        return const Color(0xFFE63946);
      case 'zoan':
        return const Color(0xFFFFD60A);
      case 'logia':
        return const Color(0xFF06D6A0);
      default:
        return const Color(0xFF457B9D);
    }
  }
}