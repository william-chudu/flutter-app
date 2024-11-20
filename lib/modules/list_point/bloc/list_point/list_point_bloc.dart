import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/list_point/index.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list_point_event.dart';
part 'list_point_state.dart';

class ListPointBloc extends Bloc<ListPointEvent, ListPointState> {
  ListPointBloc() : super(const ListPointInitial()) {
    on<GetListPoint>((GetListPoint event, Emitter<ListPointState> emit) async {
      try {
        emit(const ListPointLoading());
        await Future.delayed(const Duration(seconds: 0));
        final data = await ApiClient.shared.mPost(UrlPath.shared.listPoint, event.param.toJson());
        if (data.statusCode != 200) {
          emit(const ListPointError());
          return;
        }
        final json = jsonDecode(data.body);
        final pointJson = json['data']['listPoint'];
        if (pointJson == null) {
          emit(const ListPointError());
          return;
        }
        final points = List<PlusPoint>.from(pointJson.map((x) => PlusPoint.fromJson(x)));

        emit(ListPointLoaded(
          points: points,
          totalPointLock: json['data']['memberInfo']['total_point_lock'] ?? 0,
        ));
      } on Exception catch (e) {
        e.pError();
        emit(const ListPointError());
      }
    });
  }
}
