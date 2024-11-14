part of 'search_location_bloc.dart';

sealed class SearchLocationState {
  final Progress status;
  final bool hasValue;
  final List<List<DataSearchType>> data;

  const SearchLocationState({
    required this.status,
    required this.data,
    required this.hasValue,
  });
}

final class SearchLocationInitial extends SearchLocationState {
  const SearchLocationInitial()
      : super(
          data: const [],
          hasValue: false,
          status: Progress.initial,
        );
}

final class SearchLocationLoading extends SearchLocationState {
  const SearchLocationLoading()
      : super(
          data: const [],
          hasValue: false,
          status: Progress.loading,
        );
}

final class SearchLocationLoaded extends SearchLocationState {
  const SearchLocationLoaded({
    required super.data,
    required super.hasValue,
  }) : super(status: Progress.loaded);
}

final class SearchLocationError extends SearchLocationState {
  const SearchLocationError()
      : super(
          data: const [],
          hasValue: false,
          status: Progress.error,
        );
}
