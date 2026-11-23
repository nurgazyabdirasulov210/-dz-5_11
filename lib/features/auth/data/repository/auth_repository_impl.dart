import 'package:clean_app/core/base/base_repository.dart';
import 'package:clean_app/core/result/result.dart';
import 'package:clean_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:clean_app/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  AuthRepositoryImpl(this._datasource);
  final AuthDatasource _datasource;
  @override
  Future<Result<bool>> isLoggedIn() async { try { return Success(await _datasource.isLoggedIn()); } catch (error) { return Failed(handleError(error)); } }
  @override
  Future<Result<void>> login({required String username, required String password}) async { try { await _datasource.login(username: username, password: password); return const Success(null); } catch (error) { return Failed(handleError(error)); } }
  @override
  Future<Result<void>> logout() async { try { await _datasource.logout(); return const Success(null); } catch (error) { return Failed(handleError(error)); } }
}
