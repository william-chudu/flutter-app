part of '../index.dart';

final class AddToCartProtocol extends InheritedWidget {
  const AddToCartProtocol({super.key, required super.child, required this.onTapAddToCart});

  static AddToCartProtocol? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AddToCartProtocol>();
  }

  final void Function(String roomTypeId, String roomTypeParentId, int noOfRooms) onTapAddToCart;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}
