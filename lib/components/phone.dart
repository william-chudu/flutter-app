import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';

class PhoneWidget extends StatelessWidget {
  final double fontSize;
  final bool isGoodPrice;

  const PhoneWidget({super.key, required this.fontSize, this.isGoodPrice = false});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label.call,
            style: context.text.bodyMedium?.copyWith(fontSize: fontSize),
          ),
          TextSpan(
            text: ' 0375 65 65 05 ',
            style: context.text.titleMedium?.copyWith(
              fontSize: fontSize,
              color: AppConstants.accent,
            ),
          ),
          TextSpan(
            text: isGoodPrice ? label.forGoodPrice : '',
            style: context.text.bodyMedium?.copyWith(fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}
