part of 'history_search_bloc.dart';

sealed class HistorySearchState {
  final Progress status;
  final List<HistorySearch> list;

  const HistorySearchState({required this.status, required this.list});
}

final class HistorySearchInitial extends HistorySearchState {
  const HistorySearchInitial() : super(status: Progress.initial, list: const <HistorySearch>[]);
}

final class HistorySearchLoading extends HistorySearchState {
  const HistorySearchLoading() : super(status: Progress.loading, list: const <HistorySearch>[]);
}

final class HistorySearchLoaded extends HistorySearchState {
  const HistorySearchLoaded({required super.list, required super.status});
}

final class HistorySearchError extends HistorySearchState {
  const HistorySearchError() : super(status: Progress.error, list: const <HistorySearch>[]);
}
