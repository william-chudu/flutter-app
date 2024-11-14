part of 'hotel_room_rate_bloc.dart';

sealed class HotelRoomRateEvent {
  const HotelRoomRateEvent();
}

final class GetHotelRoomRate extends HotelRoomRateEvent {
  final ParamRoomRate param;

  const GetHotelRoomRate(this.param);
}
