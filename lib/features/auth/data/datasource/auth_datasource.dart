import 'package:clean_app/core/error/exceptions.dart';
import 'package:clean_app/core/secure_storage/token_storage.dart';

abstract class AuthDatasource {
  Future<void> login({required String username, required String password});
  Future<void> logout();
  Future<bool> isLoggedIn();
}

class AuthDatasourceImpl implements AuthDatasource {
  final TokenStorage _tokenStorage;

  AuthDatasourceImpl(this._tokenStorage);

  @override
  Future<bool> isLoggedIn() => _tokenStorage.hasToken();

  @override
  Future<void> login({required String username, required String password}) async {
    final normalizedUsername = username.trim();
    if (normalizedUsername.isEmpty) {
      throw const ServerExceptions('Введите логин');
    }
    if (password.isEmpty) {
      throw const ServerExceptions('Введите пароль');
    }

    await _tokenStorage.saveToken('demo-token-$normalizedUsername');
  }

  @override
  Future<void> logout() => _tokenStorage.deleteToken();
}
