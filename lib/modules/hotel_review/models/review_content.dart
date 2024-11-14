part of '../index.dart';

final class ReviewContent {
  String id;
  int rating;
  DateTime addDate;
  String titleVn;
  String contentVn;
  String reviewedBy;
  List<ReviewContentFacility> facilities;
  List<HotelImage> photos;
  int snippetReviewRating;

  ReviewContent({
    required this.id,
    required this.rating,
    required this.addDate,
    required this.titleVn,
    required this.contentVn,
    required this.reviewedBy,
    required this.facilities,
    required this.photos,
    required this.snippetReviewRating,
  });

  factory ReviewContent.fromJson(Map<String, dynamic> json) => ReviewContent(
        id: json["Id"],
        rating: json["Rating"],
        addDate: DateTime.parse(json["AddDate"]),
        titleVn: json["TitleVN"],
        contentVn: json["ContentVN"],
        reviewedBy: json["ReviewedBy"],
        facilities: List<ReviewContentFacility>.from(
          json["ReviewContentFacilities"].map((x) => ReviewContentFacility.fromJson(x)),
        ),
        photos: json["Photos"] != null
            ? List<HotelImage>.from(
                json["Photos"].map((x) => HotelImage(UniqueKey().toString(), x['FileName'])))
            : [],
        snippetReviewRating: json["snippetReviewRating"],
      );

  Map<String, int> jsonFaci() {
    final Map<String, int> temp = {};
    for (var i = 0; i < facilities.length; i++) {
      final item = facilities[i];
      temp[item.facilityName.toLowerCase()] = item.rating;
    }
    return temp;
  }
}

final class ReviewContentFacility {
  final String facilityName;
  final int rating;

  ReviewContentFacility({
    required this.facilityName,
    required this.rating,
  });

  factory ReviewContentFacility.fromJson(Map<String, dynamic> json) => ReviewContentFacility(
        facilityName: json["FacilityName"],
        rating: json["Rating"],
      );
}
