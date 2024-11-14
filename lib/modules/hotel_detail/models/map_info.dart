part of '../index.dart';

final class MapInfo {
  final String thumbnail;
  final String hotelname;
  final int hotelidint;
  final int starrating;
  final double pointerlongtitude;
  final double pointerlatitude;
  final int minRateHotel;
  final String hotelid;

  MapInfo({
    required this.thumbnail,
    required this.hotelname,
    required this.hotelidint,
    required this.starrating,
    required this.pointerlongtitude,
    required this.pointerlatitude,
    required this.minRateHotel,
    required this.hotelid,
  });

  factory MapInfo.fromJson(Map<String, dynamic> json) => MapInfo(
        thumbnail: json["thumbnail"],
        hotelname: json["hotelname"],
        hotelidint: json["hotelidint"],
        starrating: json["starrating"],
        pointerlongtitude: json["pointerlongtitude"]?.toDouble(),
        pointerlatitude: json["pointerlatitude"]?.toDouble(),
        minRateHotel: json["minRateHotel"],
        hotelid: json["hotelid"],
      );
}
