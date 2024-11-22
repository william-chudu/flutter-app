import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';

final class DetailReviewScore extends StatelessWidget {
  const DetailReviewScore({
    super.key,
    required this.color,
    required this.label,
    required this.worthy,
    required this.food,
    required this.staff,
    required this.room,
    required this.cleaness,
    required this.location,
  });

  final Color color;
  final LanguageLabel label;
  final String worthy;
  final String food;
  final String staff;
  final String room;
  final String cleaness;
  final String location;

  @override
  Widget build(BuildContext context) {
    const width = 50.0;
    return Column(
      children: [
        Row(
          children: [
            _ItemScoreReview(color: color, score: location, label: label.location),
            const SizedBox(width: width),
            _ItemScoreReview(color: color, score: room, label: label.room),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _ItemScoreReview(color: color, score: cleaness, label: label.cleaness),
            const SizedBox(width: width),
            _ItemScoreReview(color: color, score: staff, label: label.staff),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _ItemScoreReview(color: color, score: food, label: label.food),
            const SizedBox(width: width),
            _ItemScoreReview(color: color, score: worthy, label: label.worthTheMoney),
          ],
        ),
      ],
    );
  }
}

final class _ItemScoreReview extends StatelessWidget {
  const _ItemScoreReview({
    required this.color,
    required this.score,
    required this.label,
  });

  final Color color;
  final String score;
  final String label;

  int _setScore(String str) => ((double.tryParse(str) ?? 0) / 10).ceil();

  @override
  Widget build(BuildContext context) {
    final grade = _setScore(score);
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.text.labelSmall,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: color, width: 1.5),
                  ),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    value: grade / 10,
                    color: color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 20,
                child: Text(grade.toString(), style: context.text.bodyMedium),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
