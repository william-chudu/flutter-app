import 'package:chudu24/constants/index.dart';
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
            style: TextStyle(
              color: isDetailReview ? Colors.black : AppConstants.accent,
              fontWeight: FontWeight.w600,
              fontSize: fontSize + (isDetailReview ? 2 : 0),
            ),
          ),
          TextSpan(
            text: ' ${label.review}',
            style: TextStyle(
              color: (isDetailReview ? Colors.black87 : Colors.black54),
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
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppConstants.accent,
                ),
                child: Center(
                  child: Text(
                    averageReview,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
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
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
    );
  }
}
