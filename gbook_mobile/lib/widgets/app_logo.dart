import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 120}); // tamanho padrão = 120px

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/gbook_logo.png',
      height: size,
    );
  }
}
