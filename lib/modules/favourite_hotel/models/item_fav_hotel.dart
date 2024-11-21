part of '../index.dart';

final class ItemFavHotel {
  final String thumbnail;
  final String address1;
  final String hotelname;
  final String cityname;
  final String hotelidint;
  final String starrating;
  final String reviewcount;
  final String hotelid;
  final String cityid;
  final List<HotelTag> hotelTags;
  final int minRateHotel;
  final int minRateQuyDoiDiem;
  final int isWanted;

  ItemFavHotel({
    required this.thumbnail,
    required this.address1,
    required this.hotelname,
    required this.cityname,
    required this.hotelidint,
    required this.starrating,
    required this.reviewcount,
    required this.hotelid,
    required this.cityid,
    required this.hotelTags,
    required this.minRateHotel,
    required this.minRateQuyDoiDiem,
    required this.isWanted,
  });

  factory ItemFavHotel.fromJson(Map<String, dynamic> json) => ItemFavHotel(
        thumbnail: json["thumbnail"],
        address1: json["address1"],
        hotelname: json["hotelname"],
        cityname: json["cityname"],
        hotelidint: json["hotelidint"],
        starrating: json["starrating"],
        reviewcount: json["reviewcount"],
        hotelid: json["hotelid"],
        cityid: json["cityid"],
        hotelTags: List<HotelTag>.from(json["hotel_tags"].map((x) => HotelTag.fromJson(x))),
        minRateHotel: json["minRateHotel"],
        minRateQuyDoiDiem: json["minRateQuyDoiDiem"],
        isWanted: json["isWanted"],
      );
}
