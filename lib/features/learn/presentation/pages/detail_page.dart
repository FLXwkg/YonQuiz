import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yon_quiz/core/routes/app_routes.dart';
import '../../data/models/character_model.dart';
import '../../data/models/fruit_model.dart';
import '../controllers/learn_controller.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final type = args['type'] as String;
    final data = args['data'];

    if (type == 'fruit') {
      return _FruitDetailPage(fruit: data as FruitModel);
    } else {
      return _CharacterDetailPage(character: data as CharacterModel);
    }
  }
}

// ============================================
// PAGE DÉTAIL FRUIT
// ============================================
class _FruitDetailPage extends StatelessWidget {
  final FruitModel fruit;

  const _FruitDetailPage({required this.fruit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1D3557), Color(0xFF457B9D)],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // AppBar avec image
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              backgroundColor: const Color(0xFF06D6A0),
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  fruit.name ?? 'Fruit Inconnu',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                background: fruit.filename != null && fruit.filename!.isNotEmpty
                    ? Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            fruit.filename!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFF457B9D),
                                child: const Center(
                                  child: Icon(
                                    Icons.eco,
                                    size: 100,
                                    color: Color(0xFF06D6A0),
                                  ),
                                ),
                              );
                            },
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        color: const Color(0xFF457B9D),
                        child: const Center(
                          child: Icon(
                            Icons.eco,
                            size: 100,
                            color: Color(0xFF06D6A0),
                          ),
                        ),
                      ),
              ),
            ),

            // Contenu
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Type
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: _getTypeColor(fruit.type),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: _getTypeColor(fruit.type).withOpacity(0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          fruit.type ?? 'Type inconnu',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF1FAEE),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Nom japonais
                    if (fruit.romanName != null && fruit.romanName!.isNotEmpty)
                      _InfoSection(
                        icon: Icons.translate,
                        title: 'Nom japonais',
                        content: fruit.romanName!,
                        color: const Color(0xFFFFD60A),
                      ),

                    const SizedBox(height: 20),

                    // Description
                    if (fruit.description != null && fruit.description!.isNotEmpty)
                      _InfoSection(
                        icon: Icons.description,
                        title: 'Description',
                        content: fruit.description!,
                        color: const Color(0xFF06D6A0),
                      ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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

// ============================================
// PAGE DÉTAIL PERSONNAGE
// ============================================
class _CharacterDetailPage extends StatelessWidget {
  final CharacterModel character;

  const _CharacterDetailPage({required this.character});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LearnController());
    
    // Charger tous les personnages pour avoir les membres d'équipage
    controller.loadCharacters();

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name ?? 'Personnage Inconnu'),
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nom avec icône
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1D3557),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE63946),
                      width: 3,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 80,
                        color: Color(0xFFFFD60A),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        character.name ?? 'Inconnu',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF1FAEE),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Informations générales
              _SectionTitle(title: 'Informations', icon: Icons.info),
              const SizedBox(height: 16),
              _InfoCard(
                children: [
                  _InfoRow(
                    icon: Icons.cake,
                    label: 'Âge',
                    value: character.age ?? 'Inconnu',
                  ),
                  const Divider(color: Color(0xFF457B9D)),
                  _InfoRow(
                    icon: Icons.height,
                    label: 'Taille',
                    value: character.size ?? 'Inconnue',
                  ),
                  const Divider(color: Color(0xFF457B9D)),
                  _InfoRow(
                    icon: Icons.monetization_on,
                    label: 'Prime',
                    value: character.bounty ?? 'Aucune',
                  ),
                  const Divider(color: Color(0xFF457B9D)),
                  _InfoRow(
                    icon: Icons.work,
                    label: 'Poste',
                    value: character.job ?? 'Inconnu',
                  ),
                  const Divider(color: Color(0xFF457B9D)),
                  _InfoRow(
                    icon: Icons.favorite,
                    label: 'Statut',
                    value: character.status ?? 'Inconnu',
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Équipage
              if (character.crew != null) ...[
                _SectionTitle(title: 'Équipage', icon: Icons.group),
                const SizedBox(height: 16),
                _InfoCard(
                  children: [
                    _InfoRow(
                      icon: Icons.flag,
                      label: 'Nom',
                      value: character.crew!.name ?? 'Inconnu',
                    ),
                    const Divider(color: Color(0xFF457B9D)),
                    _InfoRow(
                      icon: Icons.people,
                      label: 'Membres',
                      value: character.crew!.number ?? '?',
                    ),
                    const Divider(color: Color(0xFF457B9D)),
                    _InfoRow(
                      icon: Icons.attach_money,
                      label: 'Prime totale',
                      value: character.crew!.totalPrime ?? 'Inconnue',
                    ),
                    const Divider(color: Color(0xFF457B9D)),
                    _InfoRow(
                      icon: Icons.star,
                      label: 'Yonko',
                      value: character.crew!.isYonko == true ? 'Oui ⭐' : 'Non',
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Membres de l'équipage
                Obx(() {
                  if (controller.isLoadingCharacters.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFFD60A),
                      ),
                    );
                  }

                  final crewMembers = controller.characters
                      .where((c) => c.crew?.name == character.crew?.name && c.id != character.id)
                      .toList();

                  if (crewMembers.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionTitle(
                        title: 'Membres de l\'équipage (${crewMembers.length})',
                        icon: Icons.people_alt,
                      ),
                      const SizedBox(height: 16),
                      ...crewMembers.map((member) => _CrewMemberCard(member: member)),
                    ],
                  );
                }),
              ],

              const SizedBox(height: 30),

              // Fruit du démon
              if (character.fruit != null) ...[
                _SectionTitle(title: 'Fruit du Démon', icon: Icons.eco),
                const SizedBox(height: 16),
                GestureDetector( 
                  onTap: () {
                    final fruitModel = FruitModel(
                      id: character.fruit!.id,
                      name: character.fruit!.name,
                      romanName: character.fruit!.romanName,
                      type: character.fruit!.type,
                      description: character.fruit!.description,
                      filename: character.fruit!.filename,
                    );

                    Get.back();
                    Get.toNamed(
                      AppRoutes.detail,
                      arguments: {'type': 'fruit', 'data': fruitModel},
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D3557),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF06D6A0),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        if (character.fruit!.filename != null &&
                            character.fruit!.filename!.isNotEmpty)
                          Container(
                            height: 150,
                            margin: const EdgeInsets.only(bottom: 16),
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
                                character.fruit!.filename!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: const Color(0xFF457B9D),
                                    child: const Icon(
                                      Icons.eco,
                                      size: 60,
                                      color: Color(0xFF06D6A0),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        
                        // Nom avec icône de clic ✅ AJOUT
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                character.fruit!.name ?? 'Inconnu',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF06D6A0),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xFF06D6A0),
                              size: 20,
                            ),
                          ],
                        ),
                        
                        if (character.fruit!.romanName != null &&
                            character.fruit!.romanName!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            character.fruit!.romanName!,
                            style: const TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Color(0xFFA8DADC),
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: _getTypeColor(character.fruit!.type),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Type: ${character.fruit!.type ?? "?"}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF1FAEE),
                            ),
                          ),
                        ),
                        if (character.fruit!.description != null &&
                            character.fruit!.description!.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          const Divider(color: Color(0xFF457B9D)),
                          const SizedBox(height: 16),
                          Text(
                            character.fruit!.description!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFFF1FAEE),
                              height: 1.5,
                            ),
                            textAlign: TextAlign.justify,
                            maxLines: 4, // ✅ Limité pour inciter à cliquer
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          // ✅ AJOUT : Indication "Voir plus"
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Appuie pour voir plus',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xFF06D6A0),
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.touch_app,
                                size: 16,
                                color: Color(0xFF06D6A0),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

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

// ============================================
// WIDGETS COMMUNS
// ============================================

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFFFFD60A),
          size: 28,
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF1FAEE),
          ),
        ),
      ],
    );
  }
}

class _InfoSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final Color color;

  const _InfoSection({
    required this.icon,
    required this.title,
    required this.content,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1D3557),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFFF1FAEE),
              height: 1.5,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;

  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1D3557),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE63946),
          width: 2,
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: const Color(0xFFFFD60A),
          ),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFFA8DADC),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFFF1FAEE),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CrewMemberCard extends StatelessWidget {
  final CharacterModel member;

  const _CrewMemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // ✅ AJOUT
      onTap: () {
        // ✅ AJOUT : Navigation vers la fiche du membre
        Get.back();
        Get.toNamed(
          AppRoutes.detail,
          arguments: {'type': 'character', 'data': member},
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1D3557),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF457B9D),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.person,
              color: Color(0xFFFFD60A),
              size: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name ?? 'Inconnu',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF1FAEE),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    member.job ?? 'Poste inconnu',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFFA8DADC),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFA8DADC),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}