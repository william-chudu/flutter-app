import 'package:chudu24/enum/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'app_theme_event.dart';
part 'app_theme_state.dart';

class AppThemeBloc extends Bloc<AppThemeEvent, AppThemeState> {
  AppThemeBloc() : super(const AppThemeState(isLight: true)) {
    on<InitializeAppTheme>((InitializeAppTheme event, Emitter<AppThemeState> emit) {
      final box = Hive.box<bool>(ConstantType.theme);

      final isLight = box.get(ConstantType.theme, defaultValue: true) ?? true;

      emit(AppThemeState(isLight: isLight));
    });

    on<ChangeAppTheme>((ChangeAppTheme event, Emitter<AppThemeState> emit) {
      final box = Hive.box<bool>(ConstantType.theme);

      box.put(ConstantType.theme, event.isLight);

      emit(AppThemeState(isLight: event.isLight));
    });
  }
}
