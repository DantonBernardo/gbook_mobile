import 'package:flutter/material.dart';
import '../molecules/login_input_field.dart';
import '../molecules/login_button.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final VoidCallback onLogin;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.onLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LoginInputField(controller: emailController, label: 'Email'),
        const SizedBox(height: 16),
        LoginInputField(controller: passwordController, label: 'Senha', obscure: true),
        const SizedBox(height: 24),
        LoginButton(isLoading: isLoading, onPressed: onLogin),
      ],
    );
  }
}
