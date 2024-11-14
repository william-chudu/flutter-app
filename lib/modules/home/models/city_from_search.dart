import 'package:chudu24/enum/index.dart';

import 'search_type.dart';

final class CityFromSearch extends DataSearchType {
  final int cityId;
  final String display;

  CityFromSearch({
    required super.type,
    required this.cityId,
    required this.display,
  });

  factory CityFromSearch.fromJson(Map<String, dynamic> json) => CityFromSearch(
        type: SearchType.city,
        cityId: json["cityId"],
        display: json["display"],
      );
}
