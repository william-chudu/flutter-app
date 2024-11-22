import 'dart:async';

import 'package:chudu24/components/detail_review_score.dart';
import 'package:chudu24/components/image_review.dart';
import 'package:chudu24/components/photo_slider.dart';
import 'package:chudu24/components/review_count.dart';
import 'package:chudu24/components/star.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/models/hotel_image.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:chudu24/modules/loading/index.dart';
import 'package:chudu24/modules/notfound/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/review_detail/review_detail_bloc.dart';

part 'models/review_content.dart';
part 'components/item_review.dart';

final class HotelReview extends StatelessWidget {
  static const String routeName = '/hotel-review';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => BlocSelector<AppSearchBloc, AppSearchState, int?>(
        selector: (state) => state.appSearch.search?.id,
        builder: (context, hotelIdInt) {
          if (hotelIdInt == null) {
            Navigator.of(context).pop();
            return const NotFoundScreen();
          }
          return BlocProvider(
            create: (context) => ReviewDetailBloc()..add(GetAllReviews(hotelIdInt)),
            child: const HotelReview(),
          );
        },
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const HotelReview({super.key});

  void onTapViewAlbums(BuildContext context, List<HotelImage> photos, double top, int index) {
    ImageReview.showImageReview(
      context: context,
      photos: photos,
      paddingTop: top,
      index: index,
    );
  }

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.viewPaddingOf(context).top + kToolbarHeight;
    return BlocBuilder<ReviewDetailBloc, ReviewDetailState>(
      builder: (ctxBloc, state) {
        if (state.status == Progress.error) {
          Timer(const Duration(milliseconds: 100), () {
            Navigator.of(context).pop();
          });
          return const NotFoundScreen();
        }

        if (state.status == Progress.loading || state.status == Progress.initial) {
          return const LoadingScreen();
        }
        final hotel = state.info.first;
        final photos = state.images;
        final reviews = state.reviews;
        final label = AppConstants.shared.label;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              hotel.hotelname,
              style: context.text.displayMedium,
            ),
          ),
          body: SafeArea(
            child: Builder(builder: (ctxBuilder) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: reviews.length + 1,
                  itemBuilder: (_, index) {
                    if (index == 0) {
                      final reviewCount = int.tryParse(hotel.reviewcount) ?? 0;
                      final reviewRatingTotal = int.tryParse(hotel.reviewratingtotal) ?? 0;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ReviewCount(
                              averageReview:
                                  (reviewCount == 0 ? 0 : (2 * reviewRatingTotal / reviewCount))
                                      .toStringAsFixed(1),
                              count: reviewCount,
                              isDetailReview: true,
                            ),
                          ),
                          const Divider(height: 40),
                          Text(
                            label.imagesFromCustomer,
                            style: context.text.displaySmall,
                          ),
                          PhotoSlider(
                            borderThickness: 3,
                            radius: 0,
                            photos: photos,
                            onTapPhoto: (index, [isJump = false]) {
                              onTapViewAlbums(ctxBuilder, photos, paddingTop, index);
                            },
                          ),
                          const Divider(height: 40),
                          Text(
                            label.reviewsFromCustomer,
                            style: context.text.displaySmall,
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    }
                    final ix = index - 1;
                    final rw = reviews[ix];
                    return ItemReview(
                      label: label,
                      paddingTop: paddingTop,
                      review: rw,
                      onTap: onTapViewAlbums,
                    );
                  },
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
