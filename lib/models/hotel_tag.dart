final class HotelTag {
  String? tagLine;
  String id;
  String tag;
  String type;

  HotelTag({
    required this.tagLine,
    required this.id,
    required this.tag,
    required this.type,
  });

  factory HotelTag.fromJson(Map<String, dynamic> json) => HotelTag(
        tagLine: json["tagLine"],
        id: json["id"],
        tag: json["tag"],
        type: json["type"],
      );
}
