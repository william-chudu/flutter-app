import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/models/header_list_items.dart';
import 'package:chudu24/modules/home/models/top_sale.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'other_promotion_event.dart';
part 'other_promotion_state.dart';

class OtherPromotionBloc extends Bloc<OtherPromotionEvent, OtherPromotionState> {
  OtherPromotionBloc() : super(const OtherPromotionInitial()) {
    on<GetOtherPromotion>((GetOtherPromotion event, Emitter<OtherPromotionState> emit) async {
      try {
        emit(const OtherPromotionInitial());
        await Future.delayed(const Duration(seconds: 0));
        final data = await ApiClient.shared.mPost(UrlPath.shared.topSale);
        if (data.statusCode != 200) {
          emit(const OtherPromotionError());
          return;
        }
        final json = jsonDecode(data.body);
        if (ApiClient.isNotOk(json['error'])) {
          emit(const OtherPromotionError());
          return;
        }
        final promotions = List<HeaderListItems<DataHangMuc>>.from(
          json['data'].map(
            (x) => HeaderListItems<DataHangMuc>(
              id: x['dataDanhMuc']['id'],
              title: x['dataDanhMuc']['tenDanhMuc'],
              items: List<DataHangMuc>.from(x['dataHangMuc'].map((y) => DataHangMuc.fromJson(y))),
            ),
          ),
        );
        emit(OtherPromotionLoaded(promotions: promotions));
      } on Exception catch (e) {
        e.pError();
        emit(const OtherPromotionError());
      }
    });
  }
}
