import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/models/map_param.dart';
import 'package:chudu24/request/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'google_map_event.dart';
part 'google_map_state.dart';

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  GoogleMapBloc() : super(const GoogleMapInitial()) {
    on<GetInfoMap>((GetInfoMap event, Emitter<GoogleMapState> emit) async {
      try {
        emit(const GoogleMapLoading());
        await Future.delayed(const Duration(seconds: 0));
        final param = event.param ?? MapParam.now;
        final GoogleMapState state = await compute((MapParam param) async {
          final data = await ApiClient.shared.mPost(UrlPath.shared.infoMap, param.toJson());
          if (data.statusCode != 200) {
            return const GoogleMapError();
          }
          final json = jsonDecode(data.body);
          if (ApiClient.isNotOk(json['error'])) {
            return const GoogleMapError();
          }
          final mainHotel = json['data']['itemHotelDefault'];
          final Set<String> duplicatedId = {mainHotel['hotelid']};
          final Set<Marker> markers = {
            Marker(
              markerId: MarkerId(mainHotel['hotelid']),
              position: LatLng(mainHotel['pointerlatitude'], mainHotel['pointerlongtitude']),
              icon: BitmapDescriptor.defaultMarker,
              infoWindow: InfoWindow(
                title: mainHotel['hotelname'],
                snippet: '${Utils.money.money(mainHotel['minRateHotel'])}.000 đ',
              ),
            )
          };

          for (int i = 0; i < json['data']['hotelData'].length; i++) {
            final x = json['data']['hotelData'][i];
            final key = x['hotelid'];
            if (!duplicatedId.contains(key)) {
              duplicatedId.add(key);
              markers.add(
                Marker(
                  markerId: MarkerId(key),
                  position: LatLng(x['pointerlatitude'], x['pointerlongtitude']),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                  infoWindow: InfoWindow(
                    title: x['hotelname'],
                    snippet: '${Utils.money.money(x['minRateHotel'])}.000 đ',
                  ),
                ),
              );
            }
          }
          return GoogleMapLoaded(markers: markers);
        }, param);
        emit(state);
      } on Exception catch (e) {
        e.pError();
        emit(const GoogleMapError());
      }
    });
  }
}
