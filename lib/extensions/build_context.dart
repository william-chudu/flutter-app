import 'package:chudu24/modules/bootstrap/protocols/theme_protocol.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get color => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
  bool get isDarkMode {
    final isSystemDark = MediaQuery.of(this).platformBrightness == Brightness.dark;
    if (isSystemDark) {
      return true;
    }

    return ThemeProtocol.of(this)?.isDarkThemeApp ?? false;
  }
}
