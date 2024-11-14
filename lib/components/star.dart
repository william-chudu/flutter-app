import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  const StarRating({super.key, required this.star, this.size = 14});

  final int star;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Icon>.filled(
        star,
        Icon(Icons.star_rate, color: Colors.amber, size: size),
      ),
    );
  }
}
