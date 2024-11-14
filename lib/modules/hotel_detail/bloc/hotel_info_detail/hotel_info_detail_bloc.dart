import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/models/hotel_info_detail.dart';
import 'package:chudu24/models/hotel_tag.dart';
import 'package:chudu24/modules/hotel_detail/index.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hotel_info_detail_event.dart';
part 'hotel_info_detail_state.dart';

class HotelInfoDetailBloc extends Bloc<HotelInfoDetailEvent, HotelInfoDetailState> {
  HotelInfoDetailBloc() : super(const HotelInfoDetailInitial()) {
    on<GetHotelInfoDetail>((GetHotelInfoDetail event, Emitter<HotelInfoDetailState> emit) async {
      try {
        emit(const HotelInfoDetailLoading());
        await Future.delayed(const Duration(seconds: 0));
        final data = await ApiClient.shared
            .mPost(UrlPath.shared.hotelInfoDetail + event.hotelIdInt.toString());
        if (data.statusCode != 200) {
          emit(const HotelInfoDetailError());
          return;
        }
        final json = jsonDecode(data.body);
        if (ApiClient.isNotOk(json['error'])) {
          emit(const HotelInfoDetailError());
          return;
        }

        final hotelTags = List<HotelTag>.from(
          jsonDecode(json['data']['hotel_tags']).map((x) => HotelTag.fromJson(x)),
        );
        final hotelDeals = List<DealOpening>.from(
          json['data']['arrDealShow'].map(
            (x) => DealOpening.fromJson(x['dataTronGoi'] != null ? x['detailRoom'] : x),
          ),
        );
        final facilities = List<Facility>.from(
          jsonDecode(json['data']['facilities']).map((x) => Facility.fromJson(x)),
        );
        final questions = List<Expansion>.from(
          jsonDecode(json['data']['hotelFQA']).map((x) => Expansion.fromJsonFQA(x)),
        );

        final info = HotelInfoDetail.fromJson(
          json['data'],
          hotelTags,
          hotelDeals,
          facilities,
          questions,
        );
        emit(HotelInfoDetailLoaded(info: [info]));
      } on Exception catch (e) {
        e.pError();
        emit(const HotelInfoDetailError());
      }
    });
  }
}
