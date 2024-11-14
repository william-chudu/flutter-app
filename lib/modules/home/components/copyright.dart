import 'package:flutter/material.dart';

class Copyright extends StatelessWidget {
  const Copyright({super.key});

  @override
  Widget build(BuildContext context) {
    const h20 = 20.0;
    return Column(
      children: [
        const Text(
          'Copyright',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: h20),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: '0375656505',
                style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: ' - Giờ hành chính (1000đ/phút)',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: h20),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: '0328381259',
                style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              TextSpan(
                text: ' - 24/7 (1000đ/phút)',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
        const SizedBox(height: h20),
      ],
    );
  }
}
