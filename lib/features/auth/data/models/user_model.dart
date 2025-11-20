import 'package:hive/hive.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart'; // Généré par build_runner

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String pseudo;

  @HiveField(2)
  final String camp; // 'marine' ou 'pirate'

  @HiveField(3)
  final String gender; // 'homme' ou 'femme'

  @HiveField(4)
  final String? email;

  @HiveField(5)
  final String? birthDate;

  @HiveField(6)
  final String? profileImagePath;

  @HiveField(7)
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.pseudo,
    required this.camp,
    required this.gender,
    this.email,
    this.birthDate,
    this.profileImagePath,
    required this.createdAt,
  });

  // Conversion vers l'entité
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      pseudo: pseudo,
      camp: camp,
      gender: gender,
      email: email,
      birthDate: birthDate,
      profileImagePath: profileImagePath,
      createdAt: createdAt,
    );
  }

  // Création depuis l'entité
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      pseudo: entity.pseudo,
      camp: entity.camp,
      gender: entity.gender,
      email: entity.email,
      birthDate: entity.birthDate,
      profileImagePath: entity.profileImagePath,
      createdAt: entity.createdAt,
    );
  }
}
