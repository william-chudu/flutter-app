import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    secondary: Colors.white70,
    outline: Colors.black54,
    primary: Colors.black87,
    surfaceTint: const Color(0xFFE6E6E6),
    secondaryContainer: Colors.grey.shade200,
    primaryContainer: const Color(0xFFE6E6E6),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.black87,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Colors.black87,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: Colors.black87,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      color: Colors.black87,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: Colors.black87,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      color: Colors.black87,
    ),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    secondary: const Color(0xBE5A5A5A),
    outline: Colors.white70,
    primary: const Color(0xFFE6E6E6),
    surfaceTint: const Color(0xFFE6E6E6),
    secondaryContainer: Colors.grey.shade800,
    primaryContainer: Colors.black87,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Color(0xFFE6E6E6),
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Color(0xFFE6E6E6),
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: Color(0xFFE6E6E6),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      color: Color(0xFFE6E6E6),
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      color: Color(0xFFE6E6E6),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      color: Color(0xFFE6E6E6),
    ),
  ),
);
