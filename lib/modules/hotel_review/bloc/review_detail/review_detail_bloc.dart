import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/models/hotel_image.dart';
import 'package:chudu24/models/hotel_info_detail.dart';
import 'package:chudu24/modules/hotel_review/index.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'review_detail_event.dart';
part 'review_detail_state.dart';

class ReviewDetailBloc extends Bloc<ReviewDetailEvent, ReviewDetailState> {
  ReviewDetailBloc() : super(const ReviewDetailInitial()) {
    on<GetAllReviews>((GetAllReviews event, Emitter<ReviewDetailState> emit) async {
      try {
        emit(const ReviewDetailLoading());
        await Future.delayed(const Duration(seconds: 0));
        final ReviewDetailState state = await compute((int hotelIdInt) async {
          final data = await ApiClient.shared.mPost(
            UrlPath.shared.hotelReviews,
            {'hotelIdInt': hotelIdInt},
          );
          if (data.statusCode != 200) {
            return const ReviewDetailError();
          }
          final json = jsonDecode(data.body);
          if (ApiClient.isNotOk(json['error'])) {
            return const ReviewDetailError();
          }
          final hotel = HotelInfoDetail.fromJson(
              json['data']['hotelRedis'], const [], const [], const [], const []);
          final photos = List<HotelImage>.from(
            json['data']['reviewphotos'].map(
              (x) => HotelImage(x['reviewcontentid'], x['filename']),
            ),
          );

          final reviews = List<ReviewContent>.from(
            json['data']['arrReviewlist'].map((x) => ReviewContent.fromJson(x)),
          );

          return ReviewDetailLoaded(
            images: photos,
            info: [hotel],
            reviews: reviews,
            isLastPage: json['data']['lastPage'],
          );
        }, event.hotelIdInt);

        emit(state);
      } on Exception catch (e) {
        e.pError();
        emit(const ReviewDetailError());
      }
    });
  }
}
