part of '../index.dart';

final class InternationalElement {
  final int id;
  final int? cityId;
  final String tieuDe;
  final String linkImage;
  final String? linkWeb;

  InternationalElement({
    required this.id,
    required this.cityId,
    required this.tieuDe,
    required this.linkImage,
    required this.linkWeb,
  });

  factory InternationalElement.fromJson(Map<String, dynamic> json) => InternationalElement(
        id: json["id"],
        cityId: json["cityId"],
        tieuDe: json["tieuDe"],
        linkImage: json["linkImage"],
        linkWeb: json["linkWeb"],
      );
}
