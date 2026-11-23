
import 'package:clean_app/core/result/result.dart';

abstract class AuthRepository {
  Future<Result<void>> login({required String username, required String password});
  Future<Result<void>> logout();
  Future<Result<bool>> isLoggedIn();
}