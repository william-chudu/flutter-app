part of 'hotel_info_detail_bloc.dart';

sealed class HotelInfoDetailEvent {
  const HotelInfoDetailEvent();
}

final class GetHotelInfoDetail extends HotelInfoDetailEvent {
  final int hotelIdInt;
  const GetHotelInfoDetail({required this.hotelIdInt});
}
