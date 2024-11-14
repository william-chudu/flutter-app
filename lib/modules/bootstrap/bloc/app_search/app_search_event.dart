part of 'app_search_bloc.dart';

final class AppSearchEvent {
  final AddressSearch? search;
  final DateTime? checkIn;
  final DateTime? checkOut;
  final int? adults;
  final int? children;
  final int? noOfRooms;
  const AppSearchEvent({
    this.search,
    this.checkIn,
    this.checkOut,
    this.adults,
    this.children,
    this.noOfRooms,
  });

  factory AppSearchEvent.fromModel(AppSearch s) => AppSearchEvent(
        search: s.search,
        checkIn: s.checkIn,
        checkOut: s.checkOut,
        adults: s.adults,
        children: s.children,
        noOfRooms: s.noOfRooms,
      );
}
