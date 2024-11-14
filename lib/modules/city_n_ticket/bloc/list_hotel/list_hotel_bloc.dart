import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/city_n_ticket/models/hotel_info.dart';
import 'package:chudu24/modules/city_n_ticket/models/param_list_hotel.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_hotel_event.dart';
part 'list_hotel_state.dart';

class ListHotelBloc extends Bloc<ListHotelEvent, ListHotelState> {
  static int value = 12345;
  int temp = 3454567;
  static bool _hasNoData(dynamic json) {
    if (json['data'] == null) {
      return true;
    }
    if (json['data']['listHotels'] == null) {
      return true;
    }
    if (json['data']['listHotels']['data'] == null) {
      return true;
    }
    if (json['data']['listHotels']['data'][0] == null) {
      return true;
    }
    return false;
  }

  ListHotelBloc() : super(const ListHotelInitial()) {
    on<GetListHotel>((GetListHotel event, Emitter<ListHotelState> emit) async {
      try {
        emit(const ListHotelLoading());
        await Future.delayed(const Duration(seconds: 0));
        final ListHotelState newState = await compute((_) async {
          final List<HotelInfo> list = List.empty(growable: true);
          final data = await ApiClient.shared.mPost(
            UrlPath.shared.listHotel,
            event.param.toJson(),
          );
          final json = jsonDecode(data.body);
          if (_hasNoData(json)) {
            return const ListHotelError();
          }
          final jsonHotels = json['data']['listHotels'];
          list.addAll(
            List<HotelInfo>.from(
              jsonHotels['data'].map((x) => HotelInfo.fromJson(x)),
            ),
          );
          return ListHotelLoaded(
            isVN: jsonHotels['isVN'],
            nextPage: event.currentPage + 1,
            param: event.param,
            hotels: list,
            total: jsonHotels['total'],
          );
        }, 0);
        emit(newState);
      } on Exception catch (e) {
        e.pError();
        emit(const ListHotelError());
      }
    });

    on<GetMoreListHotel>((GetMoreListHotel event, Emitter<ListHotelState> emit) async {
      try {
        await Future.delayed(const Duration(seconds: 0));
        final ListHotelState? newState = await compute((GetMoreListHotel ev) async {
          final List<HotelInfo> list = List.from(ev.prevHotels);
          final data = await ApiClient.shared.mPost(
            UrlPath.shared.listHotel,
            ev.param.toJson(),
          );
          final json = jsonDecode(data.body);
          if (_hasNoData(json)) {
            return null;
          }
          final jsonHotels = json['data']['listHotels'];
          list.addAll(
            List<HotelInfo>.from(
              jsonHotels['data'].map(
                (x) => HotelInfo.fromJson(x),
              ),
            ),
          );
          return ListHotelLoaded(
            isVN: jsonHotels['isVN'],
            nextPage: ev.currentPage + 1,
            param: ev.param,
            hotels: list,
            total: jsonHotels['total'],
          );
        }, event);
        emit(newState ?? state.clone());
      } on Exception catch (e) {
        e.pError();
        emit(state.clone());
      }
    });
  }
}
