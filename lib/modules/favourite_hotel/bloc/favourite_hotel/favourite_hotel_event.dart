part of 'favourite_hotel_bloc.dart';

sealed class FavouriteHotelEvent {
  const FavouriteHotelEvent();
}

final class GetFavouriteHotel extends FavouriteHotelEvent {
  final ParamFavouriteHotel param;

  const GetFavouriteHotel({required this.param});
}
