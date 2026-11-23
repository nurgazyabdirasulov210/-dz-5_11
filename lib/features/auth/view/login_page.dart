import 'package:clean_app/features/auth/view/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.error});
  final String? error;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  @override
  void dispose() { _username.dispose(); _password.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthBloc>().state is AuthLoading;
    return Scaffold(body: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 400), child: Padding(
      padding: const EdgeInsets.all(24), child: Form(key: _formKey, child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text('Вход', style: Theme.of(context).textTheme.headlineMedium), const SizedBox(height: 20),
        TextFormField(controller: _username, decoration: const InputDecoration(labelText: 'Логин'), validator: (value) => value == null || value.isEmpty ? 'Введите логин' : null),
        TextFormField(controller: _password, decoration: const InputDecoration(labelText: 'Пароль'), obscureText: true, validator: (value) => value == null || value.isEmpty ? 'Введите пароль' : null),
        if (widget.error != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(widget.error!, style: TextStyle(color: Theme.of(context).colorScheme.error))),
        const SizedBox(height: 20),
        FilledButton(onPressed: loading ? null : () { if (_formKey.currentState!.validate()) context.read<AuthBloc>().add(AuthLoginRequested(_username.text.trim(), _password.text)); }, child: loading ? const CircularProgressIndicator() : const Text('Войти')),
      ])),
    ))));
  }
}
