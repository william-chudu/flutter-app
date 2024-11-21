part of 'favourite_hotel_bloc.dart';

sealed class FavouriteHotelState {
  final Progress status;
  final List<ItemFavHotel> hotels;

  const FavouriteHotelState({required this.status, required this.hotels});
}

final class FavouriteHotelInitial extends FavouriteHotelState {
  const FavouriteHotelInitial() : super(status: Progress.initial, hotels: const []);
}

final class FavouriteHotelLoading extends FavouriteHotelState {
  const FavouriteHotelLoading() : super(status: Progress.loading, hotels: const []);
}

final class FavouriteHotelLoaded extends FavouriteHotelState {
  const FavouriteHotelLoaded({required super.hotels}) : super(status: Progress.loaded);
}

final class FavouriteHotelError extends FavouriteHotelState {
  const FavouriteHotelError() : super(status: Progress.error, hotels: const []);
}
