part of '../index.dart';

final class CheckTemCartCubit extends Cubit<Map<String, bool>> {
  CheckTemCartCubit(this.map) : super(map);

  final Map<String, bool> map;

  void checkCart(String key, bool isChecked) {
    map[key] = isChecked;
    emit(map.cast());
  }

  void checkAll(bool value) {
    map.updateAll((_, v) => v = value);
    emit(map.cast());
  }
}
