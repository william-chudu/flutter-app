import 'package:chudu24/enum/index.dart';
import 'package:chudu24/modules/home/models/search_type.dart';

final class TicketFromSearch extends DataSearchType {
  final int cityid;
  final String cityname;
  final String thumbnail;

  TicketFromSearch({
    required super.type,
    required this.cityid,
    required this.cityname,
    required this.thumbnail,
  });

  factory TicketFromSearch.fromJson(Map<String, dynamic> json) => TicketFromSearch(
        type: SearchType.ticket,
        cityid: json["cityid"],
        cityname: json["citynamevi"],
        thumbnail: json["thumbnail"],
      );
}
