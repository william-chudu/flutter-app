class TopLocation {
  String image;
  String title;
  int cityId;

  TopLocation({
    required this.image,
    required this.title,
    required this.cityId,
  });

  factory TopLocation.fromJson(Map<String, dynamic> json) => TopLocation(
        image: json["thumbnail"] ?? json['linkImage'],
        title: json["title"] ?? json['tieuDe'],
        cityId: json["cityid"] ?? json['cityId'],
      );
}
