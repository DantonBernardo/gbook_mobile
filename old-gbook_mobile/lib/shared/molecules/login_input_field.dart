import 'package:flutter/material.dart';
import '../atoms/app_text_field.dart';

class LoginInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscure;

  const LoginInputField({
    super.key,
    required this.controller,
    required this.label,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: 'Digite seu $label',
      obscure: obscure,
    );
  }
}
