import 'package:cached_network_image/cached_network_image.dart';
import 'package:chudu24/components/loading.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:flutter/material.dart';

final class ImageBuilder extends StatelessWidget {
  const ImageBuilder(
    this.url, {
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
    required this.isDarkMode,
  });

  final String url;
  final double width;
  final double height;
  final BoxFit fit;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (_, __) => const LoadingWidget(),
      width: width,
      height: height,
      fit: fit,
      colorBlendMode: isDarkMode ? BlendMode.darken : null,
      color: isDarkMode ? const Color.fromRGBO(0, 0, 0, 0.25) : null,
      errorWidget: (context, url, error) => Center(
        child: Icon(Icons.error, color: context.color.outline),
      ),
    );
  }
}
