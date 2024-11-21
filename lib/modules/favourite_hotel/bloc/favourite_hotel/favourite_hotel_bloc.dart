import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/favourite_hotel/index.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favourite_hotel_event.dart';
part 'favourite_hotel_state.dart';

class FavouriteHotelBloc extends Bloc<FavouriteHotelEvent, FavouriteHotelState> {
  FavouriteHotelBloc() : super(const FavouriteHotelInitial()) {
    on<GetFavouriteHotel>((GetFavouriteHotel event, Emitter<FavouriteHotelState> emit) async {
      try {
        emit(const FavouriteHotelLoading());
        await Future.delayed(const Duration(seconds: 0));
        final data = await ApiClient.shared.mPost(
          UrlPath.shared.favouriteHotel,
          event.param.toJson(),
        );
        if (data.statusCode != 200) {
          emit(const FavouriteHotelError());
          return;
        }
        final json = jsonDecode(data.body);
        if (ApiClient.isNotOk(json['error'])) {
          emit(const FavouriteHotelError());
          return;
        }
        final hotels = List<ItemFavHotel>.from(
          json['data']['hotels'].map((x) => ItemFavHotel.fromJson(x)),
        );
        emit(FavouriteHotelLoaded(hotels: hotels));
      } on Exception catch (e) {
        e.pError();
        emit(const FavouriteHotelError());
      }
    });
  }
}
