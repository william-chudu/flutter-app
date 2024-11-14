import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/bootstrap/models/history_search.dart';
import 'package:chudu24/modules/bootstrap/models/param_history_search.dart';
import 'package:chudu24/request/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'history_search_event.dart';
part 'history_search_state.dart';

class HistorySearchBloc extends Bloc<HistorySearchEvent, HistorySearchState> {
  HistorySearchBloc() : super(const HistorySearchInitial()) {
    on<DeleteHistorySearch>((DeleteHistorySearch event, Emitter<HistorySearchState> emit) async {
      try {
        emit(const HistorySearchLoading());
        await Future.delayed(const Duration(seconds: 0));
        final deviceId = await Utils.device.getId();
        final data = await ApiClient.shared.mPost(
          UrlPath.shared.deleteHistory,
          {'deviceId': deviceId},
        );
        if (data.statusCode != 200) {
          emit(const HistorySearchError());
          return;
        }
        final json = jsonDecode(data.body);
        if (ApiClient.isNotOk(json['error'])) {
          emit(const HistorySearchError());
          return;
        }
        emit(const HistorySearchLoaded(list: [], status: Progress.delete));
      } on Exception catch (e) {
        e.pError();
        emit(const HistorySearchError());
      }
    });
    on<GetHistorySearch>((GetHistorySearch event, Emitter<HistorySearchState> emit) async {
      try {
        emit(const HistorySearchLoading());
        await Future.delayed(const Duration(seconds: 0));
        final deviceId = await Utils.device.getId();
        final data = await ApiClient.shared.mPost(
          UrlPath.shared.historySearch,
          {'deviceId': deviceId},
        );
        if (data.statusCode != 200) {
          emit(const HistorySearchError());
          return;
        }
        final json = jsonDecode(data.body);
        if (ApiClient.isNotOk(json['error'])) {
          emit(const HistorySearchError());
          return;
        }
        final list = List<HistorySearch>.from(json['data'].map((x) => HistorySearch.fromJson(x)));
        emit(HistorySearchLoaded(list: list, status: Progress.loaded));
      } on Exception catch (e) {
        e.pError();
        emit(const HistorySearchError());
      }
    });

    on<AddNewHistorySearch>((AddNewHistorySearch event, Emitter<HistorySearchState> emit) async {
      try {
        emit(const HistorySearchLoading());
        await Future.delayed(const Duration(seconds: 0));
        final deviceId = await Utils.device.getId();
        final param = event.param.toJson();
        param['deviceId'] = deviceId;
        final data = await ApiClient.shared.mPost(UrlPath.shared.addHistorySearch, param);
        if (data.statusCode != 200) {
          emit(const HistorySearchError());
          return;
        }
        final json = jsonDecode(data.body);
        if (ApiClient.isNotOk(json['error'])) {
          emit(const HistorySearchError());
          return;
        }
        emit(const HistorySearchLoaded(list: [], status: Progress.added));
      } on Exception catch (e) {
        e.pError();
        emit(const HistorySearchError());
      }
    });
  }
}
