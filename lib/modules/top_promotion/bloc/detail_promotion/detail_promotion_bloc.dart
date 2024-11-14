import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/top_promotion/index.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_promotion_event.dart';
part 'detail_promotion_state.dart';

class DetailPromotionBloc extends Bloc<DetailPromotionEvent, DetailPromotionState> {
  DetailPromotionBloc() : super(const DetailPromotionInitial()) {
    on<GetDetailPromotion>((GetDetailPromotion event, Emitter<DetailPromotionState> emit) async {
      try {
        emit(const DetailPromotionLoading());
        await Future.delayed(const Duration(seconds: 0));
        final data = await ApiClient.shared.mPost(
          UrlPath.shared.detailPromotion,
          event.param.toJson(),
        );

        if (data.statusCode != 200) {
          emit(const DetailPromotionError());
          return;
        }

        final json = jsonDecode(data.body);
        if (ApiClient.isNotOk(json['error'])) {
          emit(const DetailPromotionError());
          return;
        }
        final detail = DetailPromotion.fromJson(json['data']);
        emit(DetailPromotionLoaded(promotions: [detail]));
      } on Exception catch (e) {
        e.pError();
        emit(const DetailPromotionError());
      }
    });
  }
}
