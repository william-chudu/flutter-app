class ParamHistorySearch {
  final String checkIn;
  final String checkOut;
  final int adults;
  final int rooms;
  final int children;
  final String keywordCityName;
  int? hotelIdInt;
  int? cityId;
  String? thumbnail;

  ParamHistorySearch({
    required this.checkIn,
    required this.checkOut,
    required this.adults,
    required this.rooms,
    required this.children,
    required this.keywordCityName,
    this.hotelIdInt,
    this.cityId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "checkIn": checkIn,
      "checkOut": checkOut,
      "adults": adults,
      "rooms": rooms,
      "children": children,
      "keywordCityName": keywordCityName,
      "hotelIdInt": hotelIdInt,
    };
    if (cityId != null) {
      map['cityId'] = cityId;
    }
    if (hotelIdInt != null) {
      map['hotelIdInt'] = hotelIdInt;
    }
    if (thumbnail != null) {
      map['thumbnail'] = thumbnail;
    }

    return map;
  }
}
