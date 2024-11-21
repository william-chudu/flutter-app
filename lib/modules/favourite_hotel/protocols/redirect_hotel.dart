part of '../index.dart';

final class RedirectHotel extends InheritedWidget {
  const RedirectHotel({super.key, required super.child, required this.onTap});

  final void Function(AddressSearch address) onTap;

  static RedirectHotel? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RedirectHotel>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
