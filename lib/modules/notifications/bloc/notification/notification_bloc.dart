import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/notifications/index.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(const NotificationInitial()) {
    on<GetNotification>((GetNotification event, Emitter<NotificationState> emit) async {
      try {
        emit(const NotificationLoading());
        await Future.delayed(const Duration(seconds: 0));
        final data = await ApiClient.shared.mPost(
          UrlPath.shared.notification,
          event.param.toJson(),
        );

        if (data.statusCode != 200) {
          emit(const NotificationError());
          return;
        }

        final json = jsonDecode(data.body);
        if (ApiClient.isNotOk(json['error'])) {
          emit(const NotificationError());
          return;
        }

        final notis = List<NotificationModel>.from(
          json['data']['listNotification'].map((x) => NotificationModel.fromJson(x)),
        );
        emit(NotificationLoaded(notis: notis));
      } on Exception catch (e) {
        e.pError();
        emit(const NotificationError());
      }
    });
  }
}
