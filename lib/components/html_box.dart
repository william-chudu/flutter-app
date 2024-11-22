import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

final class HtmlBox extends StatelessWidget {
  const HtmlBox({super.key, required this.content});

  final String? content;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: content,
      style: {
        '*': Style(
          fontSize: FontSize(context.text.bodyLarge?.fontSize ?? 16),
          padding: HtmlPaddings.zero,
          margin: Margins.zero,
        ),
      },
    );
  }
}
