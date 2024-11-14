part of 'cart_bloc.dart';

sealed class CartState {
  final Progress status;
  final List<RoomRateInfo> items;
  final Map<String, InfoCartHotel> mapRoom;
  const CartState({
    required this.status,
    required this.items,
    required this.mapRoom,
  });
}

final class CartInitial extends CartState {
  const CartInitial()
      : super(
          status: Progress.initial,
          items: const [],
          mapRoom: const {},
        );
}

final class CartLoading extends CartState {
  const CartLoading()
      : super(
          status: Progress.loading,
          items: const [],
          mapRoom: const {},
        );
}

final class CartLoaded extends CartState {
  const CartLoaded({
    required super.items,
    required super.mapRoom,
  }) : super(status: Progress.loaded);
}

final class CartError extends CartState {
  const CartError()
      : super(
          status: Progress.error,
          items: const [],
          mapRoom: const {},
        );
}
