part of '../index.dart';

final class JourneyItem {
  final String hotelnames;
  final String soDem;
  final String soPhong;
  final String reservationnumber;
  final DateTime travelfromdate;
  final DateTime traveltodate;
  final String tongGiaBan;
  final String giaoDichCongNoNccLoaiDonHang;

  JourneyItem({
    required this.hotelnames,
    required this.soDem,
    required this.soPhong,
    required this.reservationnumber,
    required this.travelfromdate,
    required this.traveltodate,
    required this.tongGiaBan,
    required this.giaoDichCongNoNccLoaiDonHang,
  });

  factory JourneyItem.fromJson(Map<String, dynamic> json) => JourneyItem(
        hotelnames: json["hotelnames"],
        soDem: json["soDem"],
        soPhong: json["soPhong"],
        reservationnumber: '${json["reservationnumber"]}',
        travelfromdate: DateTime.parse(json["travelfromdate"]),
        traveltodate: DateTime.parse(json["traveltodate"]),
        tongGiaBan: json["tongGiaBan"],
        giaoDichCongNoNccLoaiDonHang: json["giaoDichCongNoNccLoaiDonHang"],
      );
}
