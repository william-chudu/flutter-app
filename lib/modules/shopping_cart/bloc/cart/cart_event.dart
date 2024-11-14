part of 'cart_bloc.dart';

sealed class CartEvent {
  const CartEvent();
}

final class GetItemsCart extends CartEvent {
  const GetItemsCart();
}
