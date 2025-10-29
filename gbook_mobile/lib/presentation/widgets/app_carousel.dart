import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AppCarousel extends StatelessWidget {
  final List<String> imgList = [
    'assets/images/carousel/primeiro.png',
    'assets/images/carousel/segundo.png',
    'assets/images/carousel/terceiro.png',
  ];

  AppCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
      ),
      items: imgList.map((item) => Container(
        margin: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(item, fit: BoxFit.cover, width: 1000),
        ),
      )).toList(),
    );
  }
}
