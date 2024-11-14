import 'package:chudu24/modules/hotel_detail/index.dart';

import 'hotel_tag.dart';

final class HotelInfoDetail {
  final String cancellationpolicy;
  final String checkouttime;
  final String mapthumbnail;
  final String reviewnhanvien;
  final String gettingthere;
  final String checkintime;
  final String starrating;
  final String thumbnail;
  final String reviewdangtien;
  final String reviewcount;
  final String propertydetails;
  final String reviewvitri;
  final String reviewdoan;
  final String checkininstructions;
  final String otherpolicy;
  final String reviewphong;
  final String motaloaiphong;
  final String hotelidint;
  final String reviewratingtotal;
  final String reviewsachse;
  final String giaitri;
  final String cityid;
  final String pointerlongtitude;
  final String amthuc;
  final String address1;
  final String pointerlatitude;
  final String hotelname;
  final String childrenextrabedpolicy;

  final List<HotelTag> hotelTags;
  final List<DealOpening> deals;
  final List<Facility> facilities;
  final List<Expansion> hotelFQA;

  const HotelInfoDetail({
    required this.cancellationpolicy,
    required this.checkouttime,
    required this.mapthumbnail,
    required this.motaloaiphong,
    required this.reviewnhanvien,
    required this.gettingthere,
    required this.checkintime,
    required this.starrating,
    required this.thumbnail,
    required this.reviewdangtien,
    required this.hotelFQA,
    required this.reviewcount,
    required this.propertydetails,
    required this.reviewvitri,
    required this.childrenextrabedpolicy,
    required this.checkininstructions,
    required this.reviewdoan,
    required this.facilities,
    required this.otherpolicy,
    required this.reviewphong,
    required this.hotelidint,
    required this.hotelTags,
    required this.reviewratingtotal,
    required this.reviewsachse,
    required this.giaitri,
    required this.pointerlongtitude,
    required this.amthuc,
    required this.address1,
    required this.pointerlatitude,
    required this.hotelname,
    required this.deals,
    required this.cityid,
  });

  factory HotelInfoDetail.fromJson(
    Map<String, dynamic> json,
    List<HotelTag> tags,
    List<DealOpening> deals,
    List<Facility> facilities,
    List<Expansion> questions,
  ) =>
      HotelInfoDetail(
        cancellationpolicy: json["cancellationpolicy"],
        checkouttime: json["checkouttime"],
        mapthumbnail: json["mapthumbnail"],
        reviewnhanvien: json["reviewnhanvien"],
        gettingthere: json["gettingthere"],
        checkintime: json["checkintime"],
        childrenextrabedpolicy: json["childrenextrabedpolicy"],
        checkininstructions: json["checkininstructions"],
        starrating: json["starrating"],
        thumbnail: json["thumbnail"],
        reviewdangtien: json["reviewdangtien"],
        reviewcount: json["reviewcount"],
        propertydetails: json["propertydetails"],
        reviewvitri: json["reviewvitri"],
        motaloaiphong: json["motaloaiphong"],
        reviewdoan: json["reviewdoan"],
        otherpolicy: json["otherpolicy"],
        reviewphong: json["reviewphong"],
        hotelidint: json["hotelidint"],
        reviewratingtotal: json["reviewratingtotal"],
        reviewsachse: json["reviewsachse"],
        giaitri: json["giaitri"],
        cityid: json["cityid"],
        pointerlongtitude: json["pointerlongtitude"],
        amthuc: json["amthuc"],
        address1: json["address1"],
        pointerlatitude: json["pointerlatitude"],
        hotelname: json["hotelname"],
        deals: deals,
        hotelFQA: questions,
        hotelTags: tags,
        facilities: facilities,
      );
}
