import 'package:clean_app/core/result/result.dart';
import 'package:clean_app/features/auth/domain/usecases/auth_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
sealed class AuthEvent { const AuthEvent(); }
class AuthCheckRequested extends AuthEvent { const AuthCheckRequested(); }
class AuthLoginRequested extends AuthEvent { const AuthLoginRequested(this.username, this.password); final String username; final String password; }
class AuthLogoutRequested extends AuthEvent { const AuthLogoutRequested(); }
sealed class AuthState { const AuthState(); }
class AuthChecking extends AuthState { const AuthChecking(); }
class AuthUnauthenticated extends AuthState { const AuthUnauthenticated({this.error}); final String? error; }
class AuthAuthenticated extends AuthState { const AuthAuthenticated(); }
class AuthLoading extends AuthState { const AuthLoading(); }
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._login, this._check, this._logout) : super(const AuthChecking()) {
    on<AuthCheckRequested>((event, emit) async { final result = await _check(); switch (result) { case Success(data: final loggedIn): emit(loggedIn ? const AuthAuthenticated() : const AuthUnauthenticated()); case Failed(): emit(const AuthUnauthenticated()); } });
    on<AuthLoginRequested>((event, emit) async { emit(const AuthLoading()); final result = await _login(event.username, event.password); switch (result) { case Success(): emit(const AuthAuthenticated()); case Failed(failure: final failure): emit(AuthUnauthenticated(error: failure.message)); } });
    on<AuthLogoutRequested>((event, emit) async { await _logout(); emit(const AuthUnauthenticated()); });
  }
  final LoginUseCase _login; final CheckAuthUseCase _check; final LogoutUseCase _logout;
}
