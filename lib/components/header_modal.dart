import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';

final class HeaderModal extends StatelessWidget {
  const HeaderModal({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '\u{274C}',
            style: TextStyle(
              fontSize: context.text.titleMedium?.fontSize,
              color: Colors.transparent,
            ),
          ),
          SizedBox(
            height: 50,
            child: Center(
              child: Text(
                label,
                style: context.text.displayLarge,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              IconData(0x274C),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
