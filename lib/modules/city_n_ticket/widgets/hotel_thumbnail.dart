import 'package:chudu24/components/image_builder.dart';
import 'package:chudu24/modules/city_n_ticket/widgets/favorite_icon.dart';
import 'package:flutter/material.dart';

class HotelThumbnail extends StatelessWidget {
  const HotelThumbnail(
      {super.key,
      required this.thumbnail,
      required this.width,
      required double height,
      required this.isDarkMode})
      : _height = height;

  final String thumbnail;
  final double width;
  final double _height;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    const size = 40.0;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ImageBuilder(
            thumbnail,
            width: width * 2 / 5,
            height: _height,
            fit: BoxFit.fitHeight,
            isDarkMode: isDarkMode,
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white70,
            ),
            child: const FavoriteIcon(),
          ),
        ),
      ],
    );
  }
}
