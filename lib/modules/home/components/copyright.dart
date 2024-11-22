import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';

class Copyright extends StatelessWidget {
  const Copyright({super.key});

  @override
  Widget build(BuildContext context) {
    const h20 = 20.0;
    return Column(
      children: [
        Text(
          'Copyright',
          style: context.text.displaySmall,
        ),
        const SizedBox(height: h20),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '0375656505',
                style: context.text.headlineSmall?.copyWith(fontSize: 15),
              ),
              TextSpan(
                text: ' - Giờ hành chính (1000đ/phút)',
                style: context.text.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: h20),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '0328381259',
                style: context.text.headlineSmall?.copyWith(fontSize: 15),
              ),
              TextSpan(
                text: ' - 24/7 (1000đ/phút)',
                style: context.text.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: h20),
      ],
    );
  }
}
