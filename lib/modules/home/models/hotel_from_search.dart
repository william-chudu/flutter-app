import 'package:chudu24/enum/index.dart';
import 'package:chudu24/modules/home/models/search_type.dart';

final class HotelFromSearch extends DataSearchType {
  final int hotelidint;
  final String hotelname;
  final int starrating;
  final String thumbnail;
  final String address1;

  HotelFromSearch({
    required super.type,
    required this.hotelidint,
    required this.hotelname,
    required this.starrating,
    required this.thumbnail,
    required this.address1,
  });

  factory HotelFromSearch.fromJson(Map<String, dynamic> json) => HotelFromSearch(
        type: SearchType.hotel,
        hotelidint: json["hotelidint"],
        hotelname: json["hotelname"],
        starrating: json["starrating"],
        thumbnail: json["thumbnail"],
        address1: json["address1"],
      );
}
