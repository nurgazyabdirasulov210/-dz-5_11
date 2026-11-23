
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const String _tokenKey = "clean_app_token_storage";

  final FlutterSecureStorage _secureStorage;

  TokenStorage(this._secureStorage);

  // Сохранение токена
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  // Получение токена с базы данных
  Future<String?> getToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  // Удаление токена
  Future<void> deleteToken() async {
    await _secureStorage.delete(key: _tokenKey);
  }

  // Проверка наличия токена
  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null;
  }
}