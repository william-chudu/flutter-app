final class HistorySearch {
  final String checkIn;
  final String checkOut;
  final int adults;
  final int rooms;
  final int children;
  final String keywordCityName;
  final int? hotelIdInt;
  final int? cityId;
  final String? thumbnail;

  const HistorySearch({
    required this.checkIn,
    required this.checkOut,
    required this.adults,
    required this.rooms,
    required this.children,
    required this.keywordCityName,
    required this.hotelIdInt,
    required this.cityId,
    required this.thumbnail,
  });

  factory HistorySearch.fromJson(Map<String, dynamic> json) => HistorySearch(
        checkIn: json["checkIn"],
        checkOut: json["checkOut"],
        adults: json["adults"],
        rooms: json["rooms"],
        children: json["children"],
        keywordCityName: json["keywordCityName"],
        hotelIdInt: json["hotelIdInt"],
        thumbnail: json["thumbnail"],
        cityId: json["cityId"],
      );
}
