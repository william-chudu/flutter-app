import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/home/models/top_location.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'international_hotel_event.dart';
part 'international_hotel_state.dart';

class InternationalHotelBloc extends Bloc<InternationalHotelEvent, InternationalHotelState> {
  InternationalHotelBloc() : super(const InternationalHotelInitial()) {
    on<GetInternationalHotel>((
      GetInternationalHotel event,
      Emitter<InternationalHotelState> emit,
    ) async {
      try {
        emit(const InternationalHotelLoading());
        await Future.delayed(const Duration(seconds: 0));
        final data = await ApiClient.shared.mPost(UrlPath.shared.internationalHotel);
        final json = jsonDecode(data.body);
        if (_checkValue(json)) {
          emit(const InternationalHotelError());
          return;
        }
        final locations = List<TopLocation>.from(
          json['data']['upper'][0]['TrangKhuyenMaiQuocTeHangMucs'].map(
            (x) => TopLocation.fromJson(x),
          ),
        );
        emit(InternationalHotelLoaded(locations: locations));
      } on Exception catch (e) {
        e.pError();
        emit(const InternationalHotelError());
      }
    });
  }
  bool _checkValue(Map json) {
    if (json['data'] == null) {
      return true;
    }
    if (json['data']['upper'] == null) {
      return true;
    }
    if (json['data']['upper'][0] == null) {
      return true;
    }
    if (json['data']['upper'][0]['TrangKhuyenMaiQuocTeHangMucs'] == null) {
      return true;
    }
    return false;
  }
}
