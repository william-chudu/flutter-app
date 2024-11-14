import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/models/header_list_items.dart';
import 'package:chudu24/modules/international_item/index.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'international_item_event.dart';
part 'international_item_state.dart';

class InternationalItemBloc extends Bloc<InternationalItemEvent, InternationalItemState> {
  InternationalItemBloc() : super(const InternationalItemInitial()) {
    on<GetInternationalElements>((
      GetInternationalElements event,
      Emitter<InternationalItemState> emit,
    ) async {
      try {
        emit(const InternationalItemInitial());
        await Future.delayed(const Duration(seconds: 0));
        final InternationalItemState? state = await compute((_) async {
          final data = await ApiClient.shared.mPost(UrlPath.shared.internationalHotel);
          if (data.statusCode != 200) {
            return null;
          }
          final json = jsonDecode(data.body);
          if (ApiClient.isNotOk(json['error'])) {
            return null;
          }
          final topDestinations = List<InternationalElement>.from(
            json['data']['upper'][0]['TrangKhuyenMaiQuocTeHangMucs']
                .map((x) => InternationalElement.fromJson(x)),
          );
          final popularChoices = List<HeaderListItems<InternationalElement>>.from(
            json['data']['middle'].map((x) {
              final List<InternationalElement> elements = List<InternationalElement>.from(
                x['TrangKhuyenMaiQuocTeHangMucs'].map(
                  (y) => InternationalElement.fromJson(y),
                ),
              );
              return HeaderListItems(id: x['id'], title: x['countryName'], items: elements);
            }),
          );
          final travelNews = List<InternationalElement>.from(
            json['data']['bottom'][0]['TrangKhuyenMaiQuocTeHangMucs']
                .map((x) => InternationalElement.fromJson(x)),
          );
          return InternationalItemLoaded(
            popularChoices: popularChoices,
            topDestinations: topDestinations,
            travelNews: travelNews,
          );
        }, null);
        emit(state ?? const InternationalItemError());
      } on Exception catch (e) {
        e.pError();
        emit(const InternationalItemError());
      }
    });
  }
}
