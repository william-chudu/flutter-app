import 'package:chudu24/components/image_builder.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:flutter/material.dart';

final class PrioritizedChoices extends StatelessWidget {
  const PrioritizedChoices({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.width,
    required this.height,
    this.summary,
    this.onTap,
  });
  final int id;
  final String image;
  final String title;
  final String? summary;
  final double width;
  final double height;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const double radius = 10;
    final mainText = Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.text.titleLarge?.copyWith(
        color: context.color.surfaceTint,
        shadows: const [
          Shadow(offset: Offset(2, 2), blurRadius: 10),
        ],
      ),
    );
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: ImageBuilder(
              image.imgUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Container(
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(radius),
                  bottomLeft: Radius.circular(radius),
                ),
              ),
              child: summary == null
                  ? mainText
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        mainText,
                        Text(
                          summary ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.text.labelSmall?.copyWith(
                            color: context.color.surfaceTint,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: AppConstants.accent,
                          ),
                          child: Text(
                            AppConstants.shared.label.bookNow,
                            style: context.text.bodyMedium?.copyWith(
                              color: context.color.surfaceTint,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
