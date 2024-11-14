part of 'hotel_room_rate_bloc.dart';

sealed class HotelRoomRateState {
  final Progress status;
  final List<ItemRoomRate> rooms;

  const HotelRoomRateState({required this.status, required this.rooms});
}

final class HotelRoomRateInitial extends HotelRoomRateState {
  const HotelRoomRateInitial() : super(status: Progress.initial, rooms: const []);
}

final class HotelRoomRateLoading extends HotelRoomRateState {
  const HotelRoomRateLoading() : super(status: Progress.loading, rooms: const []);
}

final class HotelRoomRateLoaded extends HotelRoomRateState {
  const HotelRoomRateLoaded({required super.rooms}) : super(status: Progress.loaded);
}

final class HotelRoomRateError extends HotelRoomRateState {
  const HotelRoomRateError() : super(status: Progress.error, rooms: const []);
}
