part of 'list_hotel_bloc.dart';

final class ListHotelState {
  final Progress status;
  final ParamListHotel param;
  final int nextPage;
  final int total;
  final bool isVN;
  final List<HotelInfo> hotels;

  const ListHotelState({
    required this.status,
    required this.param,
    required this.nextPage,
    required this.total,
    required this.isVN,
    required this.hotels,
  });

  ListHotelState clone() {
    return ListHotelState(
      hotels: hotels,
      param: param,
      isVN: isVN,
      total: total,
      nextPage: nextPage,
      status: status,
    );
  }
}

final class ListHotelInitial extends ListHotelState {
  const ListHotelInitial()
      : super(
          status: Progress.initial,
          param: ParamListHotel.none,
          nextPage: 1,
          total: 0,
          isVN: true,
          hotels: const <HotelInfo>[],
        );
}

final class ListHotelLoading extends ListHotelState {
  const ListHotelLoading()
      : super(
          status: Progress.loading,
          param: ParamListHotel.none,
          nextPage: 1,
          total: 0,
          isVN: true,
          hotels: const <HotelInfo>[],
        );
}

final class ListHotelLoaded extends ListHotelState {
  const ListHotelLoaded({
    required super.isVN,
    required super.nextPage,
    required super.hotels,
    required super.total,
    required super.param,
  }) : super(status: Progress.loaded);
}

final class ListHotelError extends ListHotelState {
  const ListHotelError()
      : super(
          status: Progress.error,
          param: ParamListHotel.none,
          nextPage: 1,
          total: 0,
          isVN: true,
          hotels: const <HotelInfo>[],
        );
}
