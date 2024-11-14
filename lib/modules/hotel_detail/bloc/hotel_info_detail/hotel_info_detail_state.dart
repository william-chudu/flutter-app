part of 'hotel_info_detail_bloc.dart';

sealed class HotelInfoDetailState {
  final Progress status;
  final List<HotelInfoDetail> info;

  const HotelInfoDetailState({required this.status, required this.info});
}

final class HotelInfoDetailInitial extends HotelInfoDetailState {
  const HotelInfoDetailInitial() : super(status: Progress.initial, info: const <HotelInfoDetail>[]);
}

final class HotelInfoDetailLoading extends HotelInfoDetailState {
  const HotelInfoDetailLoading() : super(status: Progress.loading, info: const <HotelInfoDetail>[]);
}

final class HotelInfoDetailLoaded extends HotelInfoDetailState {
  const HotelInfoDetailLoaded({required super.info}) : super(status: Progress.loaded);
}

final class HotelInfoDetailError extends HotelInfoDetailState {
  const HotelInfoDetailError() : super(status: Progress.error, info: const <HotelInfoDetail>[]);
}
