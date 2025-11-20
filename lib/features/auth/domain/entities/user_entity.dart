class UserEntity {
  final String id;
  final String pseudo;
  final String camp; // 'marine' ou 'pirate'
  final String gender; // 'homme' ou 'femme'
  final String? email;
  final String? birthDate;
  final String? profileImagePath;
  final DateTime createdAt;
  final String password;

  const UserEntity({
    required this.id,
    required this.pseudo,
    required this.camp,
    required this.gender,
    this.email,
    this.birthDate,
    this.profileImagePath,
    required this.createdAt,
    required this.password,
  });
}
