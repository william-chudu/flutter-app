part of '../index.dart';

final class PlusPoint {
  final int id;
  final int point;
  final String category;
  final String actionName;
  final String createdDate;
  final String enable;
  final int pointRemain;
  final int pointDeduction;
  final String expiredated;
  final String pointString;
  final String pointDate;
  final String actionString;

  PlusPoint({
    required this.id,
    required this.point,
    required this.category,
    required this.actionName,
    required this.createdDate,
    required this.enable,
    required this.pointRemain,
    required this.pointDeduction,
    required this.expiredated,
    required this.pointString,
    required this.pointDate,
    required this.actionString,
  });

  factory PlusPoint.fromJson(Map<String, dynamic> json) => PlusPoint(
        id: json["id"],
        point: json["point"],
        category: json["category"],
        actionName: json["actionName"],
        createdDate: Utils.time.format(date: DateTime.parse(json["createdDate"])),
        enable: json["enable"],
        pointRemain: json["pointRemain"],
        pointDeduction: json["pointDeduction"],
        expiredated: json["expiredated"] == null
            ? ''
            : Utils.time.format(
                date: DateTime.parse(json["expiredated"]),
              ),
        pointString: json["pointString"],
        pointDate: json["pointDate"],
        actionString: json["actionString"],
      );
}
