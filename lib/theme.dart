import 'package:flutter/material.dart';

class CustomThemeDataClass {
  final Color primary, secondary, teritiary, accent, cardColor;
  CustomThemeDataClass({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.teritiary,
    required this.cardColor,
  });
}

CustomThemeDataClass customThemeData = CustomThemeDataClass(
  primary: const Color(0xFF312244),
  secondary: const Color(0xFF272640),
  teritiary: const Color(0xFF3e1f47),
  accent: const Color(0xFFFFFFFF),
  cardColor: const Color(0xFF4E376D),
);
