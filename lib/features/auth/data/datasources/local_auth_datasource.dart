import 'package:hive/hive.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';

class LocalAuthDatasource {
  static const String _boxName = 'users';

  /// Ouvre la box Hive
  Future<Box<UserModel>> _openBox() async {
    return await Hive.openBox<UserModel>(_boxName);
  }

  /// Sauvegarde un utilisateur (accepte UserEntity)
  Future<void> saveUser(UserEntity entity) async {
    final box = await _openBox();
    final model = UserModel.fromEntity(entity);
    await box.put(entity.id, model);
  }

  /// Récupère un utilisateur par son ID
  Future<UserEntity?> getUserById(String id) async {
    final box = await _openBox();
    final model = box.get(id);
    return model?.toEntity();
  }

  /// Récupère un utilisateur par son pseudo
  Future<UserEntity?> getUserByPseudo(String pseudo) async {
    final box = await _openBox();
    final model = box.values.firstWhere(
      (user) => user.pseudo.toLowerCase() == pseudo.toLowerCase(),
      orElse: () => UserModel(
        id: '',
        pseudo: '',
        camp: '',
        gender: '',
        createdAt: DateTime.now(),
        password: '',
      ),
    );
    
    // Si l'ID est vide, ça veut dire qu'aucun user n'a été trouvé
    if (model.id.isEmpty) return null;
    
    return model.toEntity();
  }

  /// Récupère tous les utilisateurs
  Future<List<UserEntity>> getAllUsers() async {
    final box = await _openBox();
    return box.values.map((model) => model.toEntity()).toList();
  }

  /// Supprime un utilisateur
  Future<void> deleteUser(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }

  /// Vérifie si un utilisateur existe
  Future<bool> userExists(String id) async {
    final box = await _openBox();
    return box.containsKey(id);
  }
}
