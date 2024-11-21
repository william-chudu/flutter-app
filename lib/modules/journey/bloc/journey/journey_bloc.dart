import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/journey/index.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'journey_event.dart';
part 'journey_state.dart';

class JourneyBloc extends Bloc<JourneyEvent, JourneyState> {
  JourneyBloc() : super(const JourneyInitial()) {
    on<GetAllJourney>((GetAllJourney event, Emitter<JourneyState> emit) async {
      try {
        emit(const JourneyLoading());
        await Future.delayed(const Duration(seconds: 0));
        final JourneyState newState = await compute((String accountId) async {
          final List<List<JourneyItem>> arr = await Future.wait(List.generate(3, (int index) async {
            final data = await ApiClient.shared.mPost(
              UrlPath.shared.listReservation,
              {
                'fk_account': accountId,
                'pageNumber': 1,
                'type_booking': index,
              },
            );
            if (data.statusCode != 200) {
              return const [];
            }
            final json = jsonDecode(data.body);
            if (ApiClient.isNotOk(json['error'])) {
              return const [];
            }

            return List<JourneyItem>.from(json['data']['list'].map((x) => JourneyItem.fromJson(x)));
          }));
          return JourneyLoaded(checkIn: arr[1], checkOut: arr[2], processing: arr[0]);
        }, event.accountId);
        emit(newState);
      } on Exception catch (e) {
        e.pError();
        emit(const JourneyError());
      }
    });
  }
}
