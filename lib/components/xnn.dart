import 'package:chudu24/constants/index.dart';
import 'package:flutter/material.dart';

class XnnWidget extends StatelessWidget {
  const XnnWidget({super.key, required this.isXNN, this.isBox = false});

  final bool isXNN;
  final bool isBox;

  @override
  Widget build(BuildContext context) {
    if (isXNN == false) {
      return const SizedBox.shrink();
    }
    final label = AppConstants.shared.label;
    return Container(
      decoration: isBox ? const BoxDecoration(color: Colors.orange) : null,
      padding: isBox ? const EdgeInsets.only(right: 5) : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt, color: isBox ? Colors.white : Colors.orange),
          Text(
            label.confirmNow,
            style: TextStyle(
              color: isBox ? Colors.white : Colors.orange,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
