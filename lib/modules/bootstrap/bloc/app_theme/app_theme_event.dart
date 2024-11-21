part of 'app_theme_bloc.dart';

sealed class AppThemeEvent {
  const AppThemeEvent();
}

final class InitializeAppTheme extends AppThemeEvent {
  const InitializeAppTheme();
}

final class ChangeAppTheme extends AppThemeEvent {
  final bool isLight;
  const ChangeAppTheme({required this.isLight});
}
