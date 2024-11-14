import 'package:chudu24/constants/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';

class MoneyWidget extends StatelessWidget {
  final int money;
  final double fontSize;
  const MoneyWidget({super.key, required this.money, this.fontSize = 18});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: Utils.money.money(money),
            style: TextStyle(
              color: AppConstants.accent,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: '.000',
            style: TextStyle(
              color: AppConstants.accent,
              fontSize: fontSize - 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: ' VNĐ/đêm',
            style: TextStyle(
              color: Colors.green.shade600,
              fontWeight: FontWeight.w500,
              fontSize: fontSize - 3,
            ),
          )
        ],
      ),
    );
  }
}
