part of 'shopping_cart_bloc.dart';

sealed class ShoppingCartEvent {
  const ShoppingCartEvent();
}

final class AddNewItemCart extends ShoppingCartEvent {
  final InfoCartHotel item;

  const AddNewItemCart({required this.item});
}

final class InitializeCart extends ShoppingCartEvent {
  const InitializeCart();
}
