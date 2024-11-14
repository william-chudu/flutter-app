import 'package:cached_network_image/cached_network_image.dart';
import 'package:chudu24/components/loading.dart';
import 'package:flutter/material.dart';

final class ImageBuilder extends StatelessWidget {
  const ImageBuilder(
    this.url, {
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
  });

  final String url;
  final double width;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (_, __) => const LoadingWidget(),
      width: width,
      height: height,
      fit: fit,
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error),
      ),
    );
  }
}
