import 'package:chudu24/constants/index.dart';
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
            style: TextStyle(fontSize: fontSize, color: Colors.black),
          ),
          TextSpan(
            text: ' 0375 65 65 05 ',
            style: TextStyle(
              fontSize: fontSize,
              color: AppConstants.accent,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: isGoodPrice ? label.forGoodPrice : '',
            style: TextStyle(fontSize: fontSize, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
