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
    headlineLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.blue,
      decoration: TextDecoration.underline,
      decorationColor: Colors.blue,
    ),
    headlineMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.blue,
      decoration: TextDecoration.underline,
      decorationColor: Colors.blue,
    ),
    headlineSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.blue,
      decoration: TextDecoration.underline,
      decorationColor: Colors.blue,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    bodyLarge: TextStyle(
      fontSize: 14,
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      color: Colors.black87,
    ),
    bodySmall: TextStyle(
      fontSize: 10,
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
    headlineLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.blue,
      decoration: TextDecoration.underline,
      decorationColor: Colors.blue,
    ),
    headlineMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.blue,
      decoration: TextDecoration.underline,
      decorationColor: Colors.blue,
    ),
    headlineSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.blue,
      decoration: TextDecoration.underline,
      decorationColor: Colors.blue,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color(0xFFE6E6E6),
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color(0xFFE6E6E6),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Color(0xFFE6E6E6),
    ),
    labelLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Color(0xFFE6E6E6),
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Color(0xFFE6E6E6),
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFFE6E6E6),
    ),
    bodyLarge: TextStyle(
      fontSize: 14,
      color: Color(0xFFE6E6E6),
    ),
    bodyMedium: TextStyle(
      fontSize: 12,
      color: Color(0xFFE6E6E6),
    ),
    bodySmall: TextStyle(
      fontSize: 10,
      color: Color(0xFFE6E6E6),
    ),
  ),
);
