import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get color => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
}
