import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/home/models/promotion_banner.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'promotion_banner_event.dart';
part 'promotion_banner_state.dart';

class PromotionBannerBloc extends Bloc<PromotionBannerEvent, PromotionBannerState> {
  PromotionBannerBloc() : super(const PromotionBannerInitial()) {
    on<GetPromotionBanner>((GetPromotionBanner event, Emitter<PromotionBannerState> emit) async {
      try {
        emit(const PromotionBannerLoading());
        await Future.delayed(const Duration(seconds: 0));
        final data = await ApiClient.shared.mPost(UrlPath.shared.promotionBanner);
        final json = jsonDecode(data.body);
        if (json['data'] == null || json['data']['hotelBannerBottom'] == null) {
          emit(const PromotionBannerError());
          return;
        }
        final banners = List<PromotionBanner>.from(
          json['data']['hotelBannerBottom'].map((x) => PromotionBanner.fromJson(x)),
        );
        emit(PromotionBannerLoaded(banners: banners));
      } on Exception catch (e) {
        e.pError();
        emit(const PromotionBannerError());
      }
    });
  }
}
