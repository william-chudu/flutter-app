import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/modals/modal_room_and_guest.dart';
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
            style: context.text.titleMedium?.copyWith(
              color: AppConstants.accent,
              fontSize: fontSize,
            ),
          ),
          TextSpan(
            text: '.000',
            style: context.text.labelMedium?.copyWith(
              color: AppConstants.accent,
              fontSize: fontSize - 2,
            ),
          ),
          TextSpan(
            text: ' VNĐ/đêm',
            style: context.text.labelMedium?.copyWith(
              color: Colors.green.shade600,
              fontSize: fontSize - 3,
            ),
          )
        ],
      ),
    );
  }
}
