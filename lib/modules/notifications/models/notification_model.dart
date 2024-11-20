part of '../index.dart';

final class NotificationModel {
  final int id;
  final String title;
  final String content;
  final String datePublic;
  final String urlAddress;
  final String status;

  NotificationModel({
    required this.id,
    required this.title,
    required this.content,
    required this.datePublic,
    required this.urlAddress,
    required this.status,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        datePublic: Utils.time.format(date: DateTime.parse(json["datePublic"])),
        urlAddress: json["urlAddress"],
        status: json["status"],
      );
}
