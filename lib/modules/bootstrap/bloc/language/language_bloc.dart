import 'package:chudu24/constants/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(isEn: false)) {
    AppConstants.shared.setLanguage(state.isEn);
    on<LanguageEvent>((LanguageEvent event, Emitter<LanguageState> emit) {
      AppConstants.shared.setLanguage(event.isEN);
      emit(LanguageState(isEn: event.isEN));
    });
  }
}
