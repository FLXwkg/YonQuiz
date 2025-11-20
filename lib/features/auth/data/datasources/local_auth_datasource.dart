import 'package:hive/hive.dart';
import '../models/user_model.dart';

class LocalAuthDatasource {
  static const String _boxName = 'users';
  static const String _currentUserKey = 'current_user_id';

  // Récupérer la box
  Future<Box<UserModel>> _getUserBox() async {
    return await Hive.openBox<UserModel>(_boxName);
  }

  // Sauvegarder un utilisateur
  Future<void> saveUser(UserModel user) async {
    final box = await _getUserBox();
    await box.put(user.id, user);
    
    // Définir comme utilisateur actuel
    final prefs = Hive.box('app_prefs');
    await prefs.put(_currentUserKey, user.id);
    await prefs.put('has_created_account', true);
    await prefs.put('is_logged_in', true);
    
    print('✅ Utilisateur sauvegardé: ${user.pseudo}');
  }

  // Récupérer l'utilisateur actuel
  Future<UserModel?> getCurrentUser() async {
    final prefs = Hive.box('app_prefs');
    final userId = prefs.get(_currentUserKey);
    
    if (userId == null) return null;
    
    final box = await _getUserBox();
    return box.get(userId);
  }

  // Déconnexion
  Future<void> logout() async {
    final prefs = Hive.box('app_prefs');
    await prefs.put('is_logged_in', false);
    print('👋 Utilisateur déconnecté');
  }

  // Supprimer un utilisateur
  Future<void> deleteUser(String userId) async {
    final box = await _getUserBox();
    await box.delete(userId);
    print('🗑️ Utilisateur supprimé');
  }
}
