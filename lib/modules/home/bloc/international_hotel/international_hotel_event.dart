part of 'international_hotel_bloc.dart';

sealed class InternationalHotelEvent {
  const InternationalHotelEvent();
}

final class GetInternationalHotel extends InternationalHotelEvent {
  const GetInternationalHotel();
}
