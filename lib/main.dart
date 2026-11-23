import 'package:clean_app/dependency_injection.dart';
import 'package:clean_app/features/products/view/bloc/products_bloc.dart';
import 'package:clean_app/features/products/view/bloc/products_event.dart';
import 'package:clean_app/features/products/view/products_page.dart';
import 'package:clean_app/features/auth/view/bloc/auth_bloc.dart';
import 'package:clean_app/features/auth/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => sl<AuthBloc>()..add(const AuthCheckRequested()),
        child: const _AppGate(),
      ),
    );
  }
}

class _AppGate extends StatelessWidget {
  const _AppGate();
  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
    builder: (context, state) => switch (state) {
      AuthChecking() => const Scaffold(body: Center(child: CircularProgressIndicator())),
      AuthAuthenticated() => BlocProvider(
        create: (_) => sl<ProductsBloc>()..add(const ProductsRequested()),
        child: ProductsPage(onLogout: () => context.read<AuthBloc>().add(const AuthLogoutRequested())),
      ),
      AuthUnauthenticated(:final error) => LoginPage(error: error),
      AuthLoading() => const Scaffold(body: Center(child: CircularProgressIndicator())),
    },
  );
}
