import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc() : super(const ConfigInitial()) {
    on<GetConfig>(getConfig);
  }
  void getConfig(GetConfig event, Emitter<ConfigState> emit) async {
    try {
      emit(const ConfigLoading());
      await Future.delayed(const Duration(seconds: 0));
      final dataResponse = await ApiClient.shared.mPost(UrlPath.shared.config);
      final json = jsonDecode(dataResponse.body);
      await Future.delayed(const Duration(seconds: 1));
      if (json['data'] == null) {
        emit(const ConfigError());
        return;
      }
      emit(const ConfigLoaded(config: null));
    } on Exception catch (e) {
      e.pError();
      emit(const ConfigError());
    }
  }
}
