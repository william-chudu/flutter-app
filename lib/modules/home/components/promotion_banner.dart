import 'package:carousel_slider/carousel_slider.dart';
import 'package:chudu24/components/image_builder.dart';
import 'package:chudu24/components/loading.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/promotion_banner/promotion_banner_bloc.dart';

class PromotionBanner extends StatelessWidget {
  const PromotionBanner({super.key, required this.isDarkMode});
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotionBannerBloc, PromotionBannerState>(
      builder: (context, state) {
        if (state.status == Progress.loading || state.status == Progress.initial) {
          return const LoadingWidget();
        }
        if (state.status == Progress.loaded) {
          final banners = state.banners;
          return CarouselSlider.builder(
            options: CarouselOptions(
              aspectRatio: 1140 / 150,
              autoPlay: true,
              viewportFraction: 1,
            ),
            itemCount: banners.length,
            itemBuilder: (BuildContext context, int index, int _) {
              return ImageBuilder(
                banners[index].itemUrl.imgUrl,
                fit: BoxFit.cover,
                isDarkMode: isDarkMode,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
