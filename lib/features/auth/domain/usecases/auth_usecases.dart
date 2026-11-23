import 'package:clean_app/core/result/result.dart';
import 'package:clean_app/features/auth/domain/repository/auth_repository.dart';
class LoginUseCase { LoginUseCase(this._repository); final AuthRepository _repository; Future<Result<void>> call(String username, String password) => _repository.login(username: username, password: password); }
class CheckAuthUseCase { CheckAuthUseCase(this._repository); final AuthRepository _repository; Future<Result<bool>> call() => _repository.isLoggedIn(); }
class LogoutUseCase { LogoutUseCase(this._repository); final AuthRepository _repository; Future<Result<void>> call() => _repository.logout(); }
