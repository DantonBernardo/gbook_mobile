import 'package:flutter/material.dart';
import '../widgets/app_logo.dart';
import '../shared/organisms/login_form.dart';
import '../routes/app_routes.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  final authService = AuthService(baseUrl: "http://127.0.0.1:8000/api");

  void handleLogin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final result = await authService.login(email, password);
      print("Login sucesso: $result");

      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AppLogo(size: 100),
              const SizedBox(height: 32),
              LoginForm(
                emailController: emailController,
                passwordController: passwordController,
                isLoading: isLoading,
                onLogin: handleLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
