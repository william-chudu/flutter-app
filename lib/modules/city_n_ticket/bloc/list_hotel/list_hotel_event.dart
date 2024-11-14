part of 'list_hotel_bloc.dart';

sealed class ListHotelEvent {
  const ListHotelEvent();
}

final class GetListHotel extends ListHotelEvent {
  final int currentPage;
  final ParamListHotel param;
  const GetListHotel({required this.currentPage, required this.param});
}

final class GetMoreListHotel extends ListHotelEvent {
  final int currentPage;
  final ParamListHotel param;
  final List<HotelInfo> prevHotels;
  const GetMoreListHotel({
    required this.currentPage,
    required this.param,
    required this.prevHotels,
  });
}
