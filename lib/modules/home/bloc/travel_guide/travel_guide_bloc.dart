import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/home/models/travel_guide.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'travel_guide_event.dart';
part 'travel_guide_state.dart';

class TravelGuideBloc extends Bloc<TravelGuideEvent, TravelGuideState> {
  TravelGuideBloc() : super(const TravelGuideInitial()) {
    on<GetTravelGuide>((GetTravelGuide event, Emitter<TravelGuideState> emit) async {
      try {
        emit(const TravelGuideLoading());
        await Future.delayed(const Duration(seconds: 0));
        final data = await ApiClient.shared.mPost(UrlPath.shared.travelGuide);
        final json = jsonDecode(data.body);
        if (json['data'] == null) {
          emit(const TravelGuideError());
        }
        final guides = List<TravelGuideInfo>.from(
          json['data'].map((x) => TravelGuideInfo.fromJson(x)),
        );
        emit(TravelGuideLoaded(guides: guides));
      } on Exception catch (e) {
        e.pError();
        emit(const TravelGuideError());
      }
    });
  }
}
