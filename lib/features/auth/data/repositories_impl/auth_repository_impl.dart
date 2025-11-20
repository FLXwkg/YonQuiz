import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserEntity> login(String email, String password) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    // ✅ Retourne un UserModel qui sera converti en UserEntity
    final userModel = UserModel(
      id: '1',
      pseudo: 'Luffy',  // ✅ pseudo au lieu de name
      camp: 'pirate',   // ✅ Ajouté
      gender: 'homme',  // ✅ Ajouté
      email: email,
      createdAt: DateTime.now(),
      password: password,
    );
    
    return userModel.toEntity();
  }

  @override
  Future<UserEntity> register(String email, String password, String name) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    final userModel = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      pseudo: name,
      camp: 'pirate',  // Par défaut
      gender: 'homme', // Par défaut
      email: email,
      createdAt: DateTime.now(),
      password: password,
    );
    
    return userModel.toEntity();
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    final userModel = UserModel(
      id: '1',
      pseudo: 'Test User',
      camp: 'pirate',
      gender: 'homme',
      email: 'test@example.com',
      createdAt: DateTime.now(),
      password: 'password123',
    );
    
    return userModel.toEntity();
  }

  @override
  Future<bool> isLoggedIn() async {
    return false;
  }
}
