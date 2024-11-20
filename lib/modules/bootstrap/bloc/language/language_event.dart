part of 'language_bloc.dart';

final class LanguageEvent {
  const LanguageEvent();
}

final class InitializeLanguage extends LanguageEvent {
  const InitializeLanguage();
}

final class ChangeLanguage extends LanguageEvent {
  final bool isEN;
  const ChangeLanguage({required this.isEN});
}
