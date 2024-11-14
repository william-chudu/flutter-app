part of 'search_location_bloc.dart';

sealed class SearchLocationEvent {
  const SearchLocationEvent();
}

final class GetSearchLocation extends SearchLocationEvent {
  final String keyword;
  const GetSearchLocation(this.keyword);
}

final class ClearSearchLocation extends SearchLocationEvent {
  const ClearSearchLocation();
}
