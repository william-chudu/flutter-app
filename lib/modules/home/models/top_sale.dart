final class DataHangMuc {
  final int id;
  final String tieuDe;
  final String tomTat;
  final String linkImage;
  final HotelForHangMuc hotel;
  final int idLoaiHangMuc;
  final int idDanhMuc;
  final int roomIdInt;

  DataHangMuc({
    required this.id,
    required this.tieuDe,
    required this.tomTat,
    required this.linkImage,
    required this.hotel,
    required this.idLoaiHangMuc,
    required this.idDanhMuc,
    required this.roomIdInt,
  });
  factory DataHangMuc.fromJson(Map<String, dynamic> json) => DataHangMuc(
        id: json["id"],
        tieuDe: json["tieuDe"],
        tomTat: json["tomTat"],
        linkImage: json["linkImage"],
        idLoaiHangMuc: json["idLoaiHangMuc"],
        idDanhMuc: json["id_danh_muc"],
        roomIdInt: json["Roomtype"]['roomtypeidint'],
        hotel: HotelForHangMuc.fromJson(json["Hotel"]),
      );
}

final class HotelForHangMuc {
  String id;
  int idint;
  String hotelname2;
  String countryid;

  factory HotelForHangMuc.fromJson(Map<String, dynamic> json) => HotelForHangMuc(
        id: json["id"],
        idint: json["idint"],
        hotelname2: json["hotelname2"],
        countryid: json["countryid"],
      );

  HotelForHangMuc({
    required this.id,
    required this.idint,
    required this.hotelname2,
    required this.countryid,
  });
}
