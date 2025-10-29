import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login_bloc.dart';
import '../../../data/datasources/firebase_auth_datasource.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/molecules/login_form.dart';
import '../widgets/atoms/app_logo.dart';
import '../../theme/app_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dataSource = FirebaseAuthDataSource(FirebaseAuth.instance);
    final repository = AuthRepositoryImpl(dataSource);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocProvider(
      create: (_) => LoginBloc(repository),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'app_logo',
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDark 
                          ? AppTheme.darkSurface 
                          : AppTheme.lightSurface,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const AppLogo(size: 80),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  Text(
                    'Bem-vindo de volta!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'Entre com seu e-mail e senha para continuar',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isDark 
                        ? AppTheme.darkTextSecondary 
                        : AppTheme.lightTextSecondary,
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    decoration: BoxDecoration(
                      color: isDark 
                        ? AppTheme.darkSurface 
                        : AppTheme.lightSurface,
                      borderRadius: BorderRadius.circular(20),
                      border: isDark 
                        ? null 
                        : Border.all(
                            color: AppTheme.lightSurfaceVariant,
                            width: 1,
                          ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: const LoginForm(),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Footer com link de cadastro (exemplo)
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       'Não tem uma conta? ',
                  //       style: Theme.of(context).textTheme.bodyMedium,
                  //     ),
                  //     TextButton(
                  //       onPressed: () {
                  //         // Navigate to register page
                  //       },
                  //       style: TextButton.styleFrom(
                  //         padding: const EdgeInsets.symmetric(horizontal: 8),
                  //       ),
                  //       child: const Text('Cadastre-se'),
                  //     ),
                  //   ],
                  // ),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}