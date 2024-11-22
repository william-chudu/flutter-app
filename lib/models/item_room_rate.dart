import 'package:chudu24/constants/index.dart';
import 'package:chudu24/models/hotel_image.dart';

final class ItemRoomRate {
  final String id;
  final String tenLoaiGia;
  final String? supplier;
  final String roomName;
  final String roomDescription;
  final String cancellationPolicy;
  final String roomThumbnail;
  final String roomViews;
  final String beddingName;
  final List<FacilityRoomRate> facilities;
  final List<HotelImage> roomPhotos;
  final int maxRooms;
  final int dienTich;
  final int numberOfGuestsIncludedInPrice;
  final int extraBeds;
  final int bookableNights;
  final int minRateLoaiPhong;
  final List<ArrLoaiGia> arrLoaiGia;

  ItemRoomRate({
    required this.id,
    required this.tenLoaiGia,
    required this.supplier,
    required this.roomName,
    required this.roomDescription,
    required this.cancellationPolicy,
    required this.roomThumbnail,
    required this.beddingName,
    required this.facilities,
    required this.roomViews,
    required this.roomPhotos,
    required this.maxRooms,
    required this.dienTich,
    required this.extraBeds,
    required this.numberOfGuestsIncludedInPrice,
    required this.bookableNights,
    required this.minRateLoaiPhong,
    required this.arrLoaiGia,
  });

  factory ItemRoomRate.fromJson(Map<String, dynamic> json) => ItemRoomRate(
        id: json["Id"] ?? json['roomTypeID'],
        tenLoaiGia: json["TenLoaiGia"],
        supplier: json["supplier"],
        roomName: json["RoomName"],
        roomDescription: json["RoomDescription"] ?? '',
        beddingName: json['Bedding'] != null ? json['Bedding']['beddingname'] : '',
        cancellationPolicy: json["CancellationPolicy"] ?? '',
        roomThumbnail: (json['RoomPhotos'] != null &&
                    (json['RoomPhotos'].runtimeType == List ? json['RoomPhotos'] : []).length > 0
                ? json['RoomPhotos'][0]['FileName']
                : null) ??
            (json['Photos'] != null &&
                    (json['Photos'].runtimeType == List ? json['Photos'] : []).length > 0
                ? json['Photos'][0]['filename']
                : null) ??
            AppConstants.link.noImage,
        facilities: List<FacilityRoomRate>.from(
          json["Facilities"].map((x) => FacilityRoomRate.fromJson(x)),
        ),
        roomPhotos: json["RoomPhotos"] == null
            ? []
            : List<HotelImage>.from(
                json["RoomPhotos"].map((x) => HotelImage('${x['Id']}', x['FileName'])),
              ),
        roomViews: json['Roomviews'] != null
            ? json['Roomviews'].runtimeType == String
                ? json['Roomviews']
                : List<String>.from(json['Roomviews'].map((x) => x['roomviewname'])).join()
            : '',
        numberOfGuestsIncludedInPrice: json['NumberOfGuestsIncludedInPrice'] ?? 0,
        maxRooms: json["maxRooms"] ?? 0,
        dienTich: json["DienTich"] ?? 0,
        extraBeds: json["ExtraBeds"] ?? 0,
        bookableNights: json["bookableNights"] ?? 0,
        minRateLoaiPhong: json["minRateLoaiPhong"] ?? 0,
        arrLoaiGia: List<ArrLoaiGia>.from(json["arrLoaiGia"].map((x) => ArrLoaiGia.fromJson(x))),
      );
}

final class ArrLoaiGia {
  final String? luuYChinhSach;
  final String id;
  final String tenLoaiGia;
  final String roomName;
  final String roomTypeId;
  final String roomTypeParentId;
  final String roomDescription;
  final String cancellationPolicy;
  final String beddingName;
  final String? strThoiGianO;
  final DateTime? thoiGianBanStart;
  final DateTime? thoiGianBanEnd;
  final DateTime? thoiGianSuDungStart;
  final DateTime? thoiGianSuDungEnd;
  final List<dynamic> giaiDoanKhongApDung;
  final KhuyenMaiJson? khuyenMaiJson;
  final List<GiaPhongBaoGom> roomtypesjoinroomincludes;
  final DataTronGoi? dataTronGoi;
  final bool isDisplayLoaiGia;
  final int maxRooms;
  final int bookableNights;
  final int averageRateDeal;
  final List<String> dieuKienApDung;
  final List<GiaPhongBaoGom> giaPhongBaoGom;

  ArrLoaiGia({
    required this.luuYChinhSach,
    required this.id,
    required this.tenLoaiGia,
    required this.roomName,
    required this.roomTypeId,
    required this.roomTypeParentId,
    required this.roomDescription,
    required this.cancellationPolicy,
    required this.strThoiGianO,
    required this.beddingName,
    required this.thoiGianBanStart,
    required this.thoiGianBanEnd,
    required this.thoiGianSuDungStart,
    required this.thoiGianSuDungEnd,
    required this.giaiDoanKhongApDung,
    required this.khuyenMaiJson,
    required this.roomtypesjoinroomincludes,
    required this.dataTronGoi,
    required this.isDisplayLoaiGia,
    required this.maxRooms,
    required this.bookableNights,
    required this.averageRateDeal,
    required this.dieuKienApDung,
    required this.giaPhongBaoGom,
  });

  factory ArrLoaiGia.fromJson(Map<String, dynamic> json) => ArrLoaiGia(
        luuYChinhSach: json["LuuYChinhSach"],
        id: json["Id"] ?? json['rateplanId'] ?? json['sessionId'][0],
        tenLoaiGia: json["TenLoaiGia"],
        roomTypeId: json["RoomTypeId"],
        roomTypeParentId: json["RoomTypeIdParent"] ?? '',
        roomName: json["RoomName"] ?? json['roomCode'],
        roomDescription: json["RoomDescription"] ?? '',
        cancellationPolicy: json["CancellationPolicy"] ?? '',
        beddingName: json["BeddingName"] ?? '',
        strThoiGianO: json["strThoiGianO"],
        thoiGianBanStart: DateTime.tryParse(json["ThoiGianBanStart"] ?? ''),
        thoiGianBanEnd: DateTime.tryParse(json["ThoiGianBanEnd"] ?? ''),
        thoiGianSuDungStart: DateTime.tryParse(json["ThoiGianSuDungStart"] ?? ''),
        thoiGianSuDungEnd: DateTime.tryParse(json["ThoiGianSuDungEnd"] ?? ''),
        giaiDoanKhongApDung: List<dynamic>.from(json["GiaiDoanKhongApDung"].map((x) => x)),
        khuyenMaiJson:
            json["KhuyenMaiJson"] == null ? null : KhuyenMaiJson.fromJson(json["KhuyenMaiJson"]),
        roomtypesjoinroomincludes: json["Roomtypesjoinroomincludes"] == null
            ? []
            : List<GiaPhongBaoGom>.from(
                json["Roomtypesjoinroomincludes"].map((x) => GiaPhongBaoGom.fromJson(x)),
              ),
        dataTronGoi: json["dataTronGoi"] == null ? null : DataTronGoi.fromJson(json["dataTronGoi"]),
        maxRooms: json["maxRooms"] ?? 0,
        isDisplayLoaiGia: json["isDisplayLoaiGia"] ?? true,
        bookableNights: json["bookableNights"] ?? 0,
        averageRateDeal: json["averageRateDeal"],
        dieuKienApDung: json["DieuKienApDung"] == null
            ? []
            : List<String>.from(json["DieuKienApDung"].map((x) => x)),
        giaPhongBaoGom: List<GiaPhongBaoGom>.from(
            json["GiaPhongBaoGom"].map((x) => GiaPhongBaoGom.fromJson(x))),
      );
}

final class DataTronGoi {
  final String dieuKienHuy;
  final DateTime giaiDoanSuDungDen;
  final String moTa;
  final String soNguoi;
  final String id;
  final DateTime giaiDoanSuDungTu;

  DataTronGoi({
    required this.dieuKienHuy,
    required this.giaiDoanSuDungDen,
    required this.moTa,
    required this.soNguoi,
    required this.id,
    required this.giaiDoanSuDungTu,
  });

  factory DataTronGoi.fromJson(Map<String, dynamic> json) => DataTronGoi(
        dieuKienHuy: json["dieuKienHuy"],
        giaiDoanSuDungDen: DateTime.parse(json["giaiDoanSuDungDen"]),
        moTa: json["moTa"],
        soNguoi: json["soNguoi"],
        id: json["id"],
        giaiDoanSuDungTu: DateTime.parse(json["giaiDoanSuDungTu"]),
      );
}

final class GiaPhongBaoGom {
  final String? itemid;
  final String includeName;
  final String? note;
  final String? hotelIncludeName;

  GiaPhongBaoGom({
    required this.itemid,
    required this.includeName,
    required this.note,
    required this.hotelIncludeName,
  });

  factory GiaPhongBaoGom.fromJson(Map<String, dynamic> json) => GiaPhongBaoGom(
        itemid: json["itemid"] == null ? null : '${json["itemid"] ?? json['id']}',
        includeName: json["includeName"] ?? json['hotelIncludeName'] ?? '',
        note: json["note"],
        hotelIncludeName: json["hotelIncludeName"],
      );
}

final class KhuyenMaiJson {
  final String loaiKhuyenMaiGopDem;
  final String soLuongDemGopDem;
  final String loaiKhuyenMaiTuBaoNhieuDem;
  final String soLuongDemTuBaoNhieuDem;
  final String loaiKhuyenMaiDatSom;
  final String soLuongNgayDatSom;
  final String loaiKhuyenMaiDatTrongTuan;
  final List<DatTrongTuan> datTrongTuan;

  KhuyenMaiJson({
    required this.loaiKhuyenMaiGopDem,
    required this.soLuongDemGopDem,
    required this.loaiKhuyenMaiTuBaoNhieuDem,
    required this.soLuongDemTuBaoNhieuDem,
    required this.loaiKhuyenMaiDatSom,
    required this.soLuongNgayDatSom,
    required this.loaiKhuyenMaiDatTrongTuan,
    required this.datTrongTuan,
  });

  factory KhuyenMaiJson.fromJson(Map<String, dynamic> json) => KhuyenMaiJson(
        loaiKhuyenMaiGopDem: json["loaiKhuyenMai_GopDem"],
        soLuongDemGopDem: json["soLuongDem_GopDem"],
        loaiKhuyenMaiTuBaoNhieuDem: json["loaiKhuyenMai_TuBaoNhieuDem"],
        soLuongDemTuBaoNhieuDem: json["soLuongDem_TuBaoNhieuDem"],
        loaiKhuyenMaiDatSom: json["loaiKhuyenMai_DatSom"],
        soLuongNgayDatSom: json["soLuongNgay_DatSom"],
        loaiKhuyenMaiDatTrongTuan: json["loaiKhuyenMai_DatTrongTuan"],
        datTrongTuan:
            List<DatTrongTuan>.from(json["datTrongTuan"].map((x) => DatTrongTuan.fromJson(x))),
      );
}

final class DatTrongTuan {
  final String id;
  final String text;
  final String selected;

  DatTrongTuan({
    required this.id,
    required this.text,
    required this.selected,
  });

  factory DatTrongTuan.fromJson(Map<String, dynamic> json) => DatTrongTuan(
        id: json["id"],
        text: json["text"],
        selected: json["selected"],
      );
}

final class FacilityRoomRate {
  final String? facilityId;
  final String facilityName;

  FacilityRoomRate({
    required this.facilityId,
    required this.facilityName,
  });

  factory FacilityRoomRate.fromJson(Map<String, dynamic> json) => FacilityRoomRate(
        facilityId: json["FacilityId"],
        facilityName: json["FacilityName"] ?? json['facilityname'],
      );
}
