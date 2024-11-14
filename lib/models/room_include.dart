final class RoomInclude {
  final int itemid;
  final String includeName;
  final String? note;

  RoomInclude({
    required this.itemid,
    required this.includeName,
    required this.note,
  });

  factory RoomInclude.fromJson(Map<String, dynamic> json) => RoomInclude(
        itemid: json["itemid"],
        includeName: json["includeName"],
        note: json["note"],
      );
}
