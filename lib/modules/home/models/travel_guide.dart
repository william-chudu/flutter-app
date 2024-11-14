final class TravelGuideInfo {
  int postId;
  String postTitle;
  String urlImages;
  String linkUrl;

  TravelGuideInfo({
    required this.postId,
    required this.postTitle,
    required this.urlImages,
    required this.linkUrl,
  });

  factory TravelGuideInfo.fromJson(Map<String, dynamic> json) => TravelGuideInfo(
        postId: json["postId"],
        postTitle: json["postTitle"],
        urlImages: json["urlImages"],
        linkUrl: json["linkUrl"],
      );
}
