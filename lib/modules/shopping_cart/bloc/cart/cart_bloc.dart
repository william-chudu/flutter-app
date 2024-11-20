import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/models/info_cart_hotel.dart';
import 'package:chudu24/models/param_room_rate.dart';
import 'package:chudu24/modules/bootstrap/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:chudu24/modules/shopping_cart/models/room_rate_info.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartInitial()) {
    on<GetItemsCart>((GetItemsCart event, Emitter<CartState> emit) async {
      try {
        emit(const CartLoading());
        final dir = await getApplicationDocumentsDirectory();
        final CartState newState = await compute((String path) async {
          final box = await ShoppingCartBloc.getHiveBox(path);
          final Map<String, InfoCartHotel> mapRoom = {};
          final List<RoomRateInfo?> roomRate = await Future.wait(
            box.values.map(
              (item) async {
                final param = ParamRoomRate(
                  hotelIdInt: item.hotelIdInt,
                  adult: 2,
                  children: 0,
                  numberOfRoom: 1,
                  checkIn: item.checkIn,
                  checkOut: item.checkOut,
                );
                final data = await ApiClient.shared.mPost(UrlPath.shared.roomRate, param.toJson());
                if (data.statusCode != 200) {
                  return null;
                }
                final json = jsonDecode(data.body);
                if (ApiClient.isNotOk(json['error'])) {
                  return null;
                }
                final Map<String, dynamic>? room =
                    json['data']['arrLoaiPhongDisplayAble'].firstWhere(
                  (x) => x['RoomTypeId'] == item.roomTypeParentId,
                  orElse: () => null,
                );
                if (room == null) {
                  return null;
                }
                final Map<String, dynamic>? gia = room['arrLoaiGia'].firstWhere(
                  (x) => x['RoomTypeId'] == item.roomTypeId,
                  orElse: () => null,
                );

                if (gia == null) {
                  return null;
                }
                mapRoom[item.createdAt] = item;
                return RoomRateInfo.fromJson(
                  json['data']['hotelInfo'],
                  RoomRatePriceInfo.fromJson(gia),
                  item.createdAt,
                );
              },
            ),
          );
          await box.close();
          final List<RoomRateInfo> rates = roomRate.nonNulls.toList();
          return CartLoaded(mapRoom: mapRoom, items: rates);
        }, dir.path);
        emit(newState);
      } on Exception catch (e) {
        e.pError();
        emit(const CartError());
      }
    });
  }
}
