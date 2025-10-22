import 'package:flutter/material.dart';
import '../atoms/app_button.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const LoginButton({
    super.key,
    required this.isLoading,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppButton(
      text: isLoading ? 'Carregando…' : 'Login',
      onPressed: isLoading ? null : onPressed,
    );
  }
}
