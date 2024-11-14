part of '../index.dart';

final class DetailPromotion {
  final int roomTypeIdInt;
  final int hotelIdInt;
  final int minRateVnd;
  final String sellingTime;
  final String usingTime;
  final String luuYChinhSach;
  final List<RoomInclude> giaPhongBaoGom;
  final String cancellationPolicy;
  final String roomName;
  final String tenLoaiGia;
  final String displayChannel;

  DetailPromotion({
    required this.roomTypeIdInt,
    required this.hotelIdInt,
    required this.minRateVnd,
    required this.sellingTime,
    required this.usingTime,
    required this.luuYChinhSach,
    required this.giaPhongBaoGom,
    required this.cancellationPolicy,
    required this.roomName,
    required this.tenLoaiGia,
    required this.displayChannel,
  });

  factory DetailPromotion.fromJson(Map<String, dynamic> json) {
    String modifyDate(dynamic json, String first, String second) {
      if (json[first] == null || json[second] == null) {
        return AppConstants.shared.label.noLimit;
      }
      final str = StringBuffer();
      str.write(Utils.time.format(date: DateTime.parse(json[first]), oF: TimeType.dMY));
      str.write('\n');
      str.write(Utils.time.format(date: DateTime.parse(json[second]), oF: TimeType.dMY));
      return str.toString();
    }

    return DetailPromotion(
      roomTypeIdInt: json["RoomTypeIdInt"],
      hotelIdInt: json["HotelIdInt"],
      minRateVnd: json["MinRateVnd"],
      sellingTime: modifyDate(json, 'ThoiGianBanStart', 'ThoiGianBanEnd'),
      usingTime: modifyDate(json, 'ThoiGianSuDungStart', 'ThoiGianSuDungEnd'),
      luuYChinhSach: json["LuuYChinhSach"],
      giaPhongBaoGom:
          List<RoomInclude>.from(json["GiaPhongBaoGom"].map((x) => RoomInclude.fromJson(x))),
      cancellationPolicy: json["CancellationPolicy"],
      roomName: json["RoomName"],
      tenLoaiGia: json["TenLoaiGia"],
      displayChannel: json["displayChannel"],
    );
  }
}
