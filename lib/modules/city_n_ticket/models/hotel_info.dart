import 'package:chudu24/models/hotel_tag.dart';

final class HotelInfo {
  int minRateQuyDoiDiem;
  bool isHotelRateLevelWeb;
  bool isHotelRateLevelBgt;
  bool isHotelRateLevelPhone;
  // int sortby;
  int minRateHotel;
  String thumbnail;
  String hotelname;
  // bool rate;
  int hotelidint;
  int starrating;
  int reviewcount;
  String hotelid;
  // int cityid;
  String address1;
  // String cityname;
  List<HotelTag> hotelTags;
  int reviewratingtotal;
  bool? minRateHotelIsTronGoi;
  List<dynamic>? hotelSupplierList;

  HotelInfo({
    required this.minRateQuyDoiDiem,
    required this.isHotelRateLevelWeb,
    required this.isHotelRateLevelBgt,
    required this.isHotelRateLevelPhone,
    // required this.sortby,
    required this.minRateHotel,
    required this.thumbnail,
    required this.hotelname,
    // required this.rate,
    required this.hotelidint,
    required this.starrating,
    required this.reviewcount,
    required this.hotelid,
    // required this.cityid,
    required this.address1,
    // required this.cityname,
    required this.hotelTags,
    required this.reviewratingtotal,
    this.minRateHotelIsTronGoi,
    required this.hotelSupplierList,
  });

  factory HotelInfo.fromJson(Map<String, dynamic> json) => HotelInfo(
        minRateQuyDoiDiem: json["minRateQuyDoiDiem"],
        isHotelRateLevelWeb: json["isHotelRateLevelWeb"],
        isHotelRateLevelBgt: json["isHotelRateLevelBGT"],
        isHotelRateLevelPhone: json["isHotelRateLevelPhone"],
        // sortby: json["sortby"],
        minRateHotel: json["minRateHotel"],
        thumbnail: json["thumbnail"],
        hotelname: json["hotelname"],
        // rate: json["rate"],
        hotelidint: json["hotelidint"],
        starrating: json["starrating"],
        reviewcount: json["reviewcount"],
        hotelid: json["hotelid"],
        // cityid: json["cityid"],
        address1: json["address1"],
        // cityname: json["cityname"],
        hotelTags: List<HotelTag>.from(json["hotel_tags"].map((x) => HotelTag.fromJson(x))),
        // hotelSupplierList: List<dynamic>.from(json["hotelSupplierList"].map((x) => x)),
        reviewratingtotal: json["reviewratingtotal"],
        minRateHotelIsTronGoi: json["minRateHotelIsTronGoi"],
        hotelSupplierList: json["hotelSupplierList"] == null
            ? null
            : List<dynamic>.from(json["hotelSupplierList"].map((x) => x)),
      );
}
