import 'package:chudu24/modules/bootstrap/models/address_search.dart';

final class AppSearch {
  AddressSearch? search;
  DateTime checkIn = DateTime.now().add(const Duration(days: 1));
  DateTime checkOut = DateTime.now().add(const Duration(days: 2));
  int adults = 2;
  int children = 0;
  int noOfRooms = 1;

  AppSearch();

  bool equalForSearch(AppSearch ctx) {
    if (!_isSameDate(checkIn, ctx.checkIn)) {
      return false;
    }

    if (!_isSameDate(checkOut, ctx.checkOut)) {
      return false;
    }

    if (noOfRooms != ctx.noOfRooms) {
      return false;
    }

    if (adults != ctx.adults) {
      return false;
    }

    if (children != ctx.children) {
      return false;
    }

    if (search?.id != ctx.search?.id) {
      return false;
    }

    return true;
  }

  bool _isSameDate(DateTime first, DateTime second) {
    if (first.day != second.day) {
      return false;
    }
    if (first.month != second.month) {
      return false;
    }
    if (first.year != second.year) {
      return false;
    }
    return true;
  }

  AppSearch copyWith({
    AddressSearch? search,
    DateTime? checkIn,
    DateTime? checkOut,
    int? adults,
    int? children,
    int? noOfRooms,
  }) {
    final ctx = AppSearch();
    ctx.search = search ?? this.search;
    ctx.checkIn = checkIn ?? this.checkIn;
    ctx.checkOut = checkOut ?? this.checkOut;
    ctx.adults = adults ?? this.adults;
    ctx.children = children ?? this.children;
    ctx.noOfRooms = noOfRooms ?? this.noOfRooms;
    return ctx;
  }
}
