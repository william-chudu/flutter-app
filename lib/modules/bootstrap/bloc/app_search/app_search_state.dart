part of 'app_search_bloc.dart';

final class AppSearchState {
  final Progress status = Progress.loaded;
  final AppSearch appSearch;

  const AppSearchState(this.appSearch);
}
