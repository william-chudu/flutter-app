part of 'list_point_bloc.dart';

sealed class ListPointState {
  final Progress status;
  final List<PlusPoint> points;
  final int totalPointLock;

  const ListPointState({required this.status, required this.points, required this.totalPointLock});
}

final class ListPointInitial extends ListPointState {
  const ListPointInitial() : super(status: Progress.initial, points: const [], totalPointLock: 0);
}

final class ListPointLoading extends ListPointState {
  const ListPointLoading() : super(status: Progress.loading, points: const [], totalPointLock: 0);
}

final class ListPointLoaded extends ListPointState {
  const ListPointLoaded({
    required super.points,
    required super.totalPointLock,
  }) : super(status: Progress.loaded);
}

final class ListPointError extends ListPointState {
  const ListPointError() : super(status: Progress.error, points: const [], totalPointLock: 0);
}
