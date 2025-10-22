import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import '../../../data/datasources/firebase_auth_datasource.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/molecules/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = FirebaseAuthDataSource(FirebaseAuth.instance);
    final repository = AuthRepositoryImpl(dataSource);

    return BlocProvider(
      create: (_) => LoginBloc(repository),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/gbook_logo.png', height: 120),
                  const SizedBox(height: 16),
                  const Text(
                    'Bem-vindo de volta!',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Entre com seu e-mail e senha para continuar',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 32),
                  const LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
