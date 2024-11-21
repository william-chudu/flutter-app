import 'package:flutter_bloc/flutter_bloc.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingState(isSetting: false)) {
    on<SettingEvent>((SettingEvent event, Emitter<SettingState> emit) {
      emit(SettingState(isSetting: event.isSetting));
    });
  }
}
