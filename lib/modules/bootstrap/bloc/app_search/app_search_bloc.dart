import 'package:chudu24/enum/index.dart';
import 'package:chudu24/modules/bootstrap/models/address_search.dart';
import 'package:chudu24/modules/bootstrap/models/app_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_search_event.dart';
part 'app_search_state.dart';

class AppSearchBloc extends Bloc<AppSearchEvent, AppSearchState> {
  AppSearchBloc() : super(AppSearchState(AppSearch())) {
    on<AppSearchEvent>((AppSearchEvent event, Emitter<AppSearchState> emit) {
      final newState = state.appSearch.copyWith(
        search: event.search,
        checkIn: event.checkIn,
        checkOut: event.checkOut,
        adults: event.adults,
        children: event.children,
        noOfRooms: event.noOfRooms,
      );
      emit(AppSearchState(newState));
    });
  }
}
