import 'package:chudu24/components/image_builder.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:chudu24/models/hotel_image.dart';
import 'package:flutter/material.dart';

final class PhotoSlider extends StatelessWidget {
  const PhotoSlider({
    super.key,
    required this.photos,
    this.thumbSize = 100,
    this.borderColor,
    this.controller,
    this.onTapPhoto,
    this.isFocusing = false,
    this.radius = 5,
    this.borderThickness = 5,
  });

  final double thumbSize;
  final List<HotelImage> photos;
  final Color? borderColor;
  final ScrollController? controller;
  final void Function(int, [bool])? onTapPhoto;
  final bool isFocusing;
  final double radius;
  final double borderThickness;

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return const SizedBox.shrink();
    }
    final imageSize = thumbSize - 20;
    final activeColor = borderColor ?? AppConstants.accent.withOpacity(0.8);
    final isDarkMode = context.isDarkMode;
    return Stack(
      children: [
        SizedBox(
          height: thumbSize,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            controller: controller,
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            itemCount: photos.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            itemBuilder: (ctxListview, i) {
              if (onTapPhoto != null) {
                return GestureDetector(
                  key: Key(photos[i].uuid),
                  onTap: () {
                    onTapPhoto?.call(i, true);
                  },
                  child: _ItemPhoto(
                    imageSize: imageSize,
                    photo: photos[i],
                    borderThickness: borderThickness,
                    radius: radius,
                    isDarkMode: isDarkMode,
                  ),
                );
              }
              return _ItemPhoto(
                imageSize: imageSize,
                photo: photos[i],
                key: Key(photos[i].uuid),
                borderThickness: borderThickness,
                radius: radius,
                isDarkMode: isDarkMode,
              );
            },
          ),
        ),
        if (isFocusing)
          Positioned(
            left: 0,
            bottom: 10,
            child: Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                border: Border.all(
                  width: borderThickness,
                  color: activeColor,
                ),
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ),
      ],
    );
  }
}

class _ItemPhoto extends StatelessWidget {
  const _ItemPhoto({
    super.key,
    required this.imageSize,
    required this.photo,
    required this.borderThickness,
    required this.radius,
    required this.isDarkMode,
  });

  final double borderThickness;
  final double imageSize;
  final double radius;
  final HotelImage photo;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageSize,
      height: imageSize,
      decoration: BoxDecoration(
        border: Border.all(
          width: borderThickness,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: ImageBuilder(
        key: Key(photo.uuid),
        photo.url.imgUrl,
        fit: BoxFit.cover,
        isDarkMode: isDarkMode,
      ),
    );
  }
}
