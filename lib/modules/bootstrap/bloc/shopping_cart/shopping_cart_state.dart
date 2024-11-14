part of 'shopping_cart_bloc.dart';

sealed class ShoppingCartState {
  final Progress status;
  final int count;

  const ShoppingCartState({required this.status, required this.count});
}

final class ShoppingCartInitial extends ShoppingCartState {
  const ShoppingCartInitial() : super(count: 0, status: Progress.initial);
}

final class ShoppingCartLoading extends ShoppingCartState {
  const ShoppingCartLoading({required super.count}) : super(status: Progress.loading);
}

final class ShoppingCartLoaded extends ShoppingCartState {
  const ShoppingCartLoaded({required super.count}) : super(status: Progress.loaded);
}

final class ShoppingCartAdded extends ShoppingCartState {
  const ShoppingCartAdded({required super.count}) : super(status: Progress.added);
}

final class ShoppingCartExceed extends ShoppingCartState {
  const ShoppingCartExceed() : super(status: Progress.exceed, count: 10);
}

final class ShoppingCartError extends ShoppingCartState {
  const ShoppingCartError({required super.count}) : super(status: Progress.error);
}
