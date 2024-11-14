import 'dart:convert';

import 'package:chudu24/constants/url_path.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:chudu24/modules/home/models/city_from_search.dart';
import 'package:chudu24/modules/home/models/hotel_from_search.dart';
import 'package:chudu24/modules/home/models/search_type.dart';
import 'package:chudu24/modules/home/models/ticket_from_search.dart';
import 'package:chudu24/modules/home/models/ticket_item_from_search.dart';
import 'package:chudu24/request/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_location_event.dart';
part 'search_location_state.dart';

class SearchLocationBloc extends Bloc<SearchLocationEvent, SearchLocationState> {
  SearchLocationBloc() : super(const SearchLocationInitial()) {
    on<GetSearchLocation>((GetSearchLocation event, Emitter<SearchLocationState> emit) async {
      try {
        emit(const SearchLocationLoading());
        await Future.delayed(const Duration(seconds: 0));
        final data = await ApiClient.shared.mPost(
          UrlPath.shared.searchKeyword,
          {'stringSearch': event.keyword},
        );
        if (data.statusCode != 200) {
          emit(const SearchLocationError());
          return;
        }

        final json = jsonDecode(data.body);

        if (ApiClient.isNotOk(json['error'])) {
          emit(const SearchLocationError());
          return;
        }

        final cities = List<CityFromSearch>.from(
          (json['data']['dataCity'] ?? []).map((x) => CityFromSearch.fromJson(x)),
        );
        final hotels = List<HotelFromSearch>.from(
          (json['data']['dataHotel'] ?? []).map((x) => HotelFromSearch.fromJson(x['_source'])),
        );
        final tickets = List<TicketFromSearch>.from(
          (json['data']['dataService'] ?? []).map((x) => TicketFromSearch.fromJson(x)),
        );
        final ticketItems = List<TicketItemFromSearch>.from(
          (json['data']['dataServiceItem'] ?? []).map(
            (x) => TicketItemFromSearch.fromJson(x),
          ),
        );

        final List<List<DataSearchType>> response = [cities, hotels, tickets, ticketItems];

        emit(SearchLocationLoaded(
          hasValue: cities.isNotEmpty &&
              hotels.isNotEmpty &&
              tickets.isNotEmpty &&
              ticketItems.isNotEmpty,
          data: response,
        ));
      } on Exception catch (e) {
        e.pError();
        emit(const SearchLocationError());
      }
    });

    on<ClearSearchLocation>((ClearSearchLocation event, Emitter<SearchLocationState> emit) {
      emit(const SearchLocationLoaded(data: [], hasValue: false));
    });
  }
}
