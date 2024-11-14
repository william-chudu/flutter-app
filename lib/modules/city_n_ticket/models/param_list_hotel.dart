final class ParamListHotel {
  final int cityId;
  final HotelPrices? hotelPrices;
  final int size;
  final int fromRow;
  final bool xacNhanNgay;
  final OrderBy orderBy;
  final int adult;
  final int children;
  final int rooms;
  final String checkIn;
  final String checkOut;

  const ParamListHotel({
    required this.cityId,
    this.hotelPrices,
    required this.size,
    this.fromRow = 0,
    this.xacNhanNgay = false,
    this.orderBy = const OrderBy(displayorder: 'asc'),
    required this.adult,
    required this.children,
    required this.rooms,
    required this.checkIn,
    required this.checkOut,
  });

  static const ParamListHotel none = ParamListHotel(
    cityId: 13170,
    size: 20,
    adult: 2,
    children: 0,
    rooms: 1,
    checkIn: '',
    checkOut: '',
  );

  bool isDiffFrom(ParamListHotel p) {
    if (orderBy.isDiffFrom(p.orderBy)) {
      return true;
    }
    if (xacNhanNgay != p.xacNhanNgay) {
      return true;
    }
    if (hotelPrices?.from != p.hotelPrices?.from) {
      return true;
    }
    if (hotelPrices?.to != p.hotelPrices?.to) {
      return true;
    }
    if (cityId != p.cityId) {
      return true;
    }
    if (size != p.size) {
      return true;
    }
    if (fromRow != p.fromRow) {
      return true;
    }
    if (adult != p.adult) {
      return true;
    }
    if (children != p.children) {
      return true;
    }
    if (checkIn != p.checkIn) {
      return true;
    }
    if (checkOut != p.checkOut) {
      return true;
    }
    if (rooms != p.rooms) {
      return true;
    }
    return false;
  }

  ParamListHotel copyWith({
    int? cityId,
    HotelPrices? hotelPrices,
    int? size,
    int? fromRow,
    bool? xacNhanNgay,
    OrderBy? orderBy,
    int? adult,
    int? children,
    int? rooms,
    String? checkIn,
    String? checkOut,
  }) =>
      ParamListHotel(
        cityId: cityId ?? this.cityId,
        hotelPrices: hotelPrices,
        size: size ?? this.size,
        fromRow: fromRow ?? this.fromRow,
        xacNhanNgay: xacNhanNgay ?? this.xacNhanNgay,
        orderBy: orderBy ?? this.orderBy,
        adult: adult ?? this.adult,
        children: children ?? this.children,
        rooms: rooms ?? this.rooms,
        checkIn: checkIn ?? this.checkIn,
        checkOut: checkOut ?? this.checkOut,
      );

  Map<String, dynamic> toJson() => {
        "cityId": cityId,
        "hotelPrices": hotelPrices?.toJson(),
        "size": size,
        "fromRow": fromRow,
        "xacNhanNgay": xacNhanNgay,
        "orderBy": orderBy.toJson(),
        "adult": adult,
        "children": children,
        "rooms": rooms,
        "checkIn": checkIn,
        "checkOut": checkOut,
      };
}

class HotelPrices {
  final int from;
  final int to;

  const HotelPrices({required this.from, required this.to});

  HotelPrices copyWith({int? from, int? to}) => HotelPrices(
        from: from ?? this.from,
        to: to ?? this.to,
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
      };
}

class OrderBy {
  final String? displayorder;
  final String? minratevnd;
  final String? starrating;
  final String? reviewcount;

  const OrderBy({
    this.displayorder,
    this.minratevnd,
    this.starrating,
    this.reviewcount,
  });

  bool isDiffFrom(OrderBy o) {
    if (displayorder != o.displayorder) {
      return true;
    }
    if (minratevnd != o.minratevnd) {
      return true;
    }
    if (starrating != o.starrating) {
      return true;
    }
    if (reviewcount != o.reviewcount) {
      return true;
    }
    return false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (displayorder != null) {
      map['displayorder'] = displayorder;
    }

    if (minratevnd != null) {
      map['minratevnd'] = minratevnd;
    }

    if (starrating != null) {
      map['starrating'] = starrating;
    }

    if (reviewcount != null) {
      map['reviewcount'] = reviewcount;
    }
    return map;
  }

  OrderBy copyWith({
    String? displayorder,
    String? minratevnd,
    String? starrating,
    String? reviewcount,
  }) {
    return OrderBy(
      displayorder: displayorder ?? this.displayorder,
      minratevnd: minratevnd ?? this.minratevnd,
      starrating: starrating ?? this.starrating,
      reviewcount: reviewcount ?? this.reviewcount,
    );
  }
}
