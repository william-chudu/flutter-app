import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/home/models/top_location.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_destination_event.dart';
part 'top_destination_state.dart';

class TopDestinationBloc extends Bloc<TopDestinationEvent, TopDestinationState> {
  TopDestinationBloc() : super(const TopDestinationInitial()) {
    on<GetTopDestination>((GetTopDestination event, Emitter<TopDestinationState> emit) async {
      try {
        emit(const TopDestinationLoading());
        await Future.delayed(const Duration(seconds: 0));
        final data = await ApiClient.shared.mPost(UrlPath.shared.topDestination);
        final json = jsonDecode(data.body);
        if (json['data'] == null) {
          emit(const TopDestinationError());
          return;
        }
        final locations = List<TopLocation>.from(
          json['data'].map((x) => TopLocation.fromJson(x)),
        );
        emit(TopDestinationLoaded(locations: locations));
      } on Exception catch (e) {
        e.pError();
        emit(const TopDestinationError());
      }
    });
  }
}
