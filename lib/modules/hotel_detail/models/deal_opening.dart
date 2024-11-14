part of '../index.dart';

final class DealOpening {
  final String? luuYChinhSach;
  final int minRateVnd;
  final String tenLoaiGia;
  final String roomDescription;
  final String cancellationPolicy;
  final DateTime thoiGianBanStart;
  final DateTime thoiGianBanEnd;
  final DateTime thoiGianSuDungStart;
  final DateTime thoiGianSuDungEnd;
  final List<RoomInclude> roomIncludes;

  DealOpening({
    required this.luuYChinhSach,
    required this.minRateVnd,
    required this.tenLoaiGia,
    required this.roomDescription,
    required this.cancellationPolicy,
    required this.thoiGianBanStart,
    required this.thoiGianBanEnd,
    required this.thoiGianSuDungStart,
    required this.thoiGianSuDungEnd,
    required this.roomIncludes,
  });
  factory DealOpening.fromJson(Map<String, dynamic> json) => DealOpening(
        luuYChinhSach: json["LuuYChinhSach"],
        minRateVnd: json["MinRateVnd"],
        tenLoaiGia: json["TenLoaiGia"],
        roomDescription: json["RoomDescription"],
        cancellationPolicy: json["CancellationPolicy"],
        thoiGianBanStart: DateTime.parse(json["ThoiGianBanStart"]),
        thoiGianBanEnd: DateTime.parse(json["ThoiGianBanEnd"]),
        thoiGianSuDungStart: DateTime.parse(json["ThoiGianSuDungStart"]),
        thoiGianSuDungEnd: DateTime.parse(json["ThoiGianSuDungEnd"]),
        roomIncludes: List<RoomInclude>.from(
          json["Roomtypesjoinroomincludes"].map((x) => RoomInclude.fromJson(x)),
        ),
      );
}
