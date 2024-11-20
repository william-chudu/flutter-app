import 'package:carousel_slider/carousel_slider.dart';
import 'package:chudu24/components/loading.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:chudu24/models/hotel_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'photo_slider.dart';

final class ImageReview extends StatefulWidget {
  static void showImageReview({
    required BuildContext context,
    required List<HotelImage> photos,
    required double paddingTop,
    bool hasAppbar = true,
    int index = 0,
    bool isFocusing = true,
  }) {
    showBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return ImageReview(
          photos: photos,
          paddingTop: paddingTop,
          initialIndex: index,
          hasAppbar: hasAppbar,
          isFocusing: isFocusing,
        );
      },
    );
  }

  const ImageReview({
    super.key,
    required this.photos,
    required this.paddingTop,
    required this.initialIndex,
    required this.hasAppbar,
    required this.isFocusing,
  });

  final List<HotelImage> photos;
  final double paddingTop;
  final int initialIndex;
  final bool hasAppbar;
  final bool isFocusing;

  @override
  State<ImageReview> createState() => _ImageReviewState();
}

class _ImageReviewState extends State<ImageReview> {
  CarouselSliderController? sliderController;
  ScrollController? photoController;
  int page = -1;

  @override
  void initState() {
    super.initState();
    sliderController = CarouselSliderController();
    photoController = ScrollController();
    setState(() {});
  }

  void changeIndex(int page, [bool isJump = false]) {
    if (widget.isFocusing) {
      photoController?.animateTo(
        page * 100,
        duration: const Duration(milliseconds: 400),
        curve: Curves.linear,
      );
    }
    if (isJump) {
      sliderController?.jumpToPage(page);
    } else {
      sliderController?.animateToPage(page);
    }
  }

  @override
  void dispose() {
    sliderController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (sliderController == null || photoController == null) {
      return const SizedBox.shrink();
    }
    final viewHeight = MediaQuery.of(context).size.height;
    final photos = widget.photos;
    const thumbSize = 100.0;
    const iconSize = 50.0;
    final positionIcon = (viewHeight - widget.paddingTop - thumbSize - iconSize) / 2;
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (widget.hasAppbar)
          SizedBox(
            height: widget.paddingTop,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        IconData(0x274C),
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        Expanded(
          child: Stack(
            children: [
              CarouselSlider.builder(
                itemCount: photos.length,
                carouselController: sliderController,
                options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: 1,
                  initialPage: widget.initialIndex,
                ),
                itemBuilder: (BuildContext sliderCtx, int index, _) {
                  if (page != -1) {
                    changeIndex(index);
                  }
                  page = index;
                  return PhotoView(
                    key: Key(photos[index].uuid),
                    loadingBuilder: (context, event) {
                      return const LoadingWidget(label: 'Image loading...');
                    },
                    imageProvider: NetworkImage(photos[index].url.imgUrl),
                    backgroundDecoration: const BoxDecoration(color: Colors.grey),
                  );
                },
              ),
              Positioned(
                left: 0,
                top: positionIcon,
                child: GestureDetector(
                  onTap: () {
                    changeIndex(page - 1);
                  },
                  child: const Icon(
                    Icons.chevron_left_rounded,
                    size: iconSize,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: positionIcon,
                child: GestureDetector(
                  onTap: () {
                    changeIndex(page + 1);
                  },
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    size: iconSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: PhotoSlider(
            photos: photos,
            controller: photoController,
            onTapPhoto: changeIndex,
            isFocusing: widget.isFocusing,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
