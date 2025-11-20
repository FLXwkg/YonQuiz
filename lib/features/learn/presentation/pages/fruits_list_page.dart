import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                          controller.searchQuery.value.isEmpty
                              ? 'Aucun fruit disponible'
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
                  itemCount: fruits.length,
                  itemBuilder: (context, index) {
                    final fruit = fruits[index];
                    return _FruitCard(fruit: fruit);
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

// Widget pour afficher une carte de fruit
class _FruitCard extends StatelessWidget {
  final dynamic fruit;

  const _FruitCard({required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            ],
          ),

          // Description
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
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
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