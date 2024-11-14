import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/models/item_room_rate.dart';
import 'package:chudu24/models/param_room_rate.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hotel_room_rate_event.dart';
part 'hotel_room_rate_state.dart';

class HotelRoomRateBloc extends Bloc<HotelRoomRateEvent, HotelRoomRateState> {
  HotelRoomRateBloc() : super(const HotelRoomRateInitial()) {
    on<GetHotelRoomRate>((GetHotelRoomRate event, Emitter<HotelRoomRateState> emit) async {
      try {
        emit(const HotelRoomRateLoading());
        await Future.delayed(const Duration(seconds: 0));
        final HotelRoomRateState state = await compute(
          (ParamRoomRate param) async {
            final data = await ApiClient.shared.mPost(UrlPath.shared.roomRate, param.toJson());
            if (data.statusCode != 200) {
              return const HotelRoomRateError();
            }
            final json = jsonDecode(data.body);
            if (ApiClient.isNotOk(json['error'])) {
              return const HotelRoomRateError();
            }
            final rooms = List<ItemRoomRate>.from(json['data']['allLoaiPhongDisplayAble'].map(
              (x) => ItemRoomRate.fromJson(x),
            ));
            return HotelRoomRateLoaded(rooms: rooms);
          },
          event.param,
        );
        emit(state);
      } on Exception catch (e) {
        e.pError();
        emit(const HotelRoomRateError());
      }
    });
  }
}
