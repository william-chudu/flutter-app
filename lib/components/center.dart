import 'package:flutter/material.dart';

final class CenterWidget extends StatelessWidget {
  final String title;

  const CenterWidget(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.black26,
            decoration: TextDecoration.underline,
            decorationColor: Colors.black12,
            decorationThickness: 0.5,
          ),
        ),
      ),
    );
  }
}
