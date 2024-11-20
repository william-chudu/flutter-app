import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(isEn: false)) {
    AppConstants.shared.setLanguage(state.isEn);

    on<InitializeLanguage>((InitializeLanguage event, Emitter<LanguageState> emit) {
      final box = Hive.box<bool>(ConstantType.language);
      final isEN = box.get(ConstantType.language, defaultValue: false) ?? false;

      AppConstants.shared.setLanguage(isEN);
      emit(LanguageState(isEn: isEN));
    });

    on<ChangeLanguage>((ChangeLanguage event, Emitter<LanguageState> emit) {
      AppConstants.shared.setLanguage(event.isEN);

      final box = Hive.box<bool>(ConstantType.language);
      box.put(ConstantType.language, event.isEN);

      emit(LanguageState(isEn: event.isEN));
    });
  }
}
