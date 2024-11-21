import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';

final class BoxPlaceholderInput extends StatelessWidget {
  const BoxPlaceholderInput({
    super.key,
    this.flex = 1,
    required this.label,
    this.content,
    this.padding = const EdgeInsets.all(10),
    this.hasBackground = false,
  });

  final int flex;
  final String label;
  final String? content;
  final EdgeInsetsGeometry padding;
  final bool hasBackground;

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      label,
      style: TextStyle(fontSize: 16, color: context.color.outline),
    );
    return Expanded(
      flex: flex,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: hasBackground ? null : context.color.secondary,
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
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: context.color.primary,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
