final class RoomRateInfo {
  final String hotelName;
  final String address;
  final String thumbnail;
  final String star;
  final String reviews;
  final String createdAt;
  final RoomRatePriceInfo priceInfo;

  const RoomRateInfo({
    required this.hotelName,
    required this.address,
    required this.thumbnail,
    required this.star,
    required this.reviews,
    required this.priceInfo,
    required this.createdAt,
  });

  factory RoomRateInfo.fromJson(
    Map<String, dynamic> json,
    RoomRatePriceInfo priceInfo,
    String createdAt,
  ) =>
      RoomRateInfo(
        hotelName: json['hotelname'],
        address: json['address1'],
        thumbnail: json['thumbnail'],
        star: json['starrating'],
        reviews: json['reviewcount'],
        createdAt: createdAt,
        priceInfo: priceInfo,
      );
}

final class RoomRatePriceInfo {
  final String roomTypeId;
  final String roomName;
  final int price;

  const RoomRatePriceInfo({required this.roomTypeId, required this.roomName, required this.price});

  factory RoomRatePriceInfo.fromJson(Map<String, dynamic> json) => RoomRatePriceInfo(
        roomTypeId: json['RoomTypeId'],
        roomName: '${json['RoomName']} - ${json['TenLoaiGia']}',
        price: json['averageRateDeal'],
      );
}
