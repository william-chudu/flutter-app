import 'package:chudu24/enum/index.dart';

final class AddressSearch {
  int id;
  String title;
  String thumbnail;
  SearchType type;

  AddressSearch({
    required this.id,
    required this.title,
    required this.type,
    this.thumbnail = '',
  });

  factory AddressSearch.clone(AddressSearch a) => AddressSearch(
        id: a.id,
        title: a.title,
        thumbnail: a.thumbnail,
        type: a.type,
      );
}
