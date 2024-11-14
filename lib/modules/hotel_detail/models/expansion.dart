part of '../index.dart';

final class Expansion {
  final String id;
  final String title;
  final String content;

  const Expansion({required this.id, required this.title, required this.content});

  // static Expansion none = const Expansion(id: '', title: '', content: '');

  factory Expansion.fromJsonFQA(Map<String, dynamic> json) => Expansion(
        id: '${json["id"]}',
        title: json["questtion"],
        content: json["answer"],
      );
}
