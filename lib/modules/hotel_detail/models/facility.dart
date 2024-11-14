part of '../index.dart';

final class Facility {
  String facilityId;
  String facilityName;

  Facility({
    required this.facilityId,
    required this.facilityName,
  });

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        facilityId: json["FacilityId"],
        facilityName: json["Facilityinfos"][0]['FacilityName'],
      );
}
