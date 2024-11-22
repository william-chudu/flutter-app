import 'package:flutter/material.dart';

final class ThemeProtocol extends InheritedWidget {
  const ThemeProtocol({super.key, required super.child, required this.isDarkThemeApp});

  final bool isDarkThemeApp;

  static ThemeProtocol? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProtocol>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
