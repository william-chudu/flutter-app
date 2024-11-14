part of 'history_search_bloc.dart';

sealed class HistorySearchEvent {
  const HistorySearchEvent();
}

final class GetHistorySearch extends HistorySearchEvent {
  const GetHistorySearch();
}

final class DeleteHistorySearch extends HistorySearchEvent {
  const DeleteHistorySearch();
}

final class AddNewHistorySearch extends HistorySearchEvent {
  final ParamHistorySearch param;

  const AddNewHistorySearch({required this.param});
}
