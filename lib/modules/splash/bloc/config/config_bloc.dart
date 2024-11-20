import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/models/authenticated_user.dart';
import 'package:chudu24/models/info_cart_hotel.dart';
import 'package:chudu24/models/memship_account_profile.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

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

      final appDocumentDirectory = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);
      Hive.registerAdapter(CartHotelAdapter());
      Hive.registerAdapter(AuthernticatedUserAdapter());
      Hive.registerAdapter(MemShipAccountProfileAdapter());

      final data = await Future.wait([
        Hive.openBox<bool>(ConstantType.language),
        ApiClient.shared.mPost(UrlPath.shared.config)
      ]);

      final json = jsonDecode((data[1] as dynamic).body);
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
