part of 'list_point_bloc.dart';

sealed class ListPointEvent {
  const ListPointEvent();
}

final class GetListPoint extends ListPointEvent {
  final ParamListPoint param;

  const GetListPoint({required this.param});
}
