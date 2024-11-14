import 'package:flutter/material.dart';

final class BoxPlaceholderInput extends StatelessWidget {
  const BoxPlaceholderInput({
    super.key,
    this.flex = 1,
    required this.label,
    this.content,
    this.padding = const EdgeInsets.all(10),
  });

  final int flex;
  final String label;
  final String? content;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      label,
      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
    );
    return Expanded(
      flex: flex,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        padding: padding,
        child: content == null
            ? textWidget
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget,
                  Text(
                    content ?? '',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
      ),
    );
  }
}
