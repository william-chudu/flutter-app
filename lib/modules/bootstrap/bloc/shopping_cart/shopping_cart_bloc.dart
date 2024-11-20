import 'dart:io';

import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/models/info_cart_hotel.dart';
import 'package:chudu24/models/pair.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

part 'shopping_cart_event.dart';
part 'shopping_cart_state.dart';

final class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  static Future<Box<InfoCartHotel>> getHiveBox(String path) async {
    Hive.registerAdapter(CartHotelAdapter(), override: true);
    return await Hive.openBox<InfoCartHotel>(
      ConstantType.hotel,
      path: path,
    );
  }

  ShoppingCartBloc() : super(const ShoppingCartInitial()) {
    on<AddNewItemCart>((AddNewItemCart event, Emitter<ShoppingCartState> emit) async {
      try {
        emit(ShoppingCartLoading(count: state.count + event.item.noOfRooms));

        final ShoppingCartState newState = await compute(
          (Pair<InfoCartHotel, Directory> pair) async {
            final box = await getHiveBox(pair.second.path);
            final total = box.values.length;
            if (total < 10) {
              await box.add(pair.first);
              return ShoppingCartAdded(count: total + 1);
            }
            await box.close();
            return const ShoppingCartExceed();
          },
          Pair(event.item, await getApplicationDocumentsDirectory()),
        );
        emit(newState);
      } on Exception catch (e) {
        e.pError();
        emit(ShoppingCartError(count: state.count + event.item.noOfRooms));
      }
    });

    on<InitializeCart>((InitializeCart event, Emitter<ShoppingCartState> emit) async {
      try {
        emit(const ShoppingCartLoading(count: 0));
        final dir = await getApplicationDocumentsDirectory();
        final box = await getHiveBox(dir.path);
        final count = box.values.length;
        emit(ShoppingCartLoaded(count: count));
        await box.close();
      } on Exception catch (e) {
        e.pError();
        emit(const ShoppingCartError(count: 0));
      }
    });
  }
}
