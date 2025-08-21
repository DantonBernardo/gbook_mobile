import 'package:flutter/material.dart';

class AppCarousel extends StatelessWidget {
  const AppCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/carousel/primeiro.png',
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
