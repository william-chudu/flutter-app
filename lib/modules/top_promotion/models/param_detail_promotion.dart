part of '../index.dart';

final class ParamDetailPromotion {
  final int idDanhMuc;
  final int idHotel;
  final int idRoomType;

  ParamDetailPromotion({
    required this.idDanhMuc,
    required this.idHotel,
    required this.idRoomType,
  });

  Map<String, dynamic> toJson() => {
        "idDanhMuc": idDanhMuc,
        "idHotel": idHotel,
        "idRoomType": idRoomType,
      };
}
