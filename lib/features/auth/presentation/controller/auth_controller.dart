import 'package:get/get.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository repository;

  AuthController({required this.repository});

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final RxnString _error = RxnString();
  String? get error => _error.value;

  final RxBool _isAuthenticated = false.obs;
  bool get isAuthenticated => _isAuthenticated.value;

  final RxnString _userEmail = RxnString();
  String? get userEmail => _userEmail.value;

  Future<void> login(String email, String password) async {
    _isLoading.value = true;
    _error.value = null;

    try {
      final user = await repository.login(email, password);
      _userEmail.value = user.email;
      _isAuthenticated.value = true;
    } catch (e) {
      _error.value = 'Login failed: $e';
      _isAuthenticated.value = false;
    } finally {
      _isLoading.value = false;
    }
  }

  void logout() {
    _isAuthenticated.value = false;
    _userEmail.value = null;
    _error.value = null;
  }
}
