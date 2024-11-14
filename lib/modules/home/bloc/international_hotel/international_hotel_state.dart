part of 'international_hotel_bloc.dart';

sealed class InternationalHotelState {
  final Progress status;
  final List<TopLocation> locations;

  const InternationalHotelState({required this.status, required this.locations});
}

final class InternationalHotelInitial extends InternationalHotelState {
  const InternationalHotelInitial()
      : super(status: Progress.initial, locations: const <TopLocation>[]);
}

final class InternationalHotelLoading extends InternationalHotelState {
  const InternationalHotelLoading()
      : super(status: Progress.loading, locations: const <TopLocation>[]);
}

final class InternationalHotelLoaded extends InternationalHotelState {
  const InternationalHotelLoaded({required super.locations}) : super(status: Progress.loaded);
}

final class InternationalHotelError extends InternationalHotelState {
  const InternationalHotelError() : super(status: Progress.error, locations: const <TopLocation>[]);
}
