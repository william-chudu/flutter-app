import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';

class ReviewCount extends StatelessWidget {
  const ReviewCount({
    super.key,
    required this.count,
    required this.averageReview,
    this.isDetailReview = false,
    this.fontSize = 14,
  });

  final int count;
  final String averageReview;
  final bool isDetailReview;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    final review = RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$count',
            style: context.text.labelMedium?.copyWith(
              color: isDetailReview ? context.color.primary : AppConstants.accent,
              fontSize: fontSize + (isDetailReview ? 2 : 0),
            ),
          ),
          TextSpan(
            text: ' ${label.review}',
            style: context.text.bodyLarge?.copyWith(
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: isDetailReview
          ? [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppConstants.accent,
                ),
                child: Center(
                  child: Text(
                    averageReview,
                    style: context.text.displaySmall?.copyWith(color: context.color.surfaceTint),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              review,
            ]
          : [
              review,
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                decoration: BoxDecoration(
                  color: AppConstants.accent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  averageReview,
                  style: context.text.bodyMedium?.copyWith(color: context.color.surfaceTint),
                ),
              ),
            ],
    );
  }
}
