import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:chudu24/modules/city_n_ticket/bloc/list_hotel/list_hotel_bloc.dart';
import 'package:chudu24/modules/city_n_ticket/components/appbar_title.dart';
import 'package:chudu24/modules/city_n_ticket/models/param_list_hotel.dart';
import 'package:chudu24/modules/notfound/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/list_hotels.dart';
import 'components/filter_sort.dart';

class CityNTicket extends StatelessWidget {
  static const String routeName = '/city-n-ticket';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const CityNTicket(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const CityNTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppbarTitle(),
        forceMaterialTransparency: true,
      ),
      body: BlocBuilder<AppSearchBloc, AppSearchState>(
        builder: (context, state) {
          final data = state.appSearch;
          final cityId = data.search?.id;
          if (cityId == null) {
            Navigator.pop(context);
            return const NotFoundScreen();
          }
          final paramSearch = ParamListHotel(
            cityId: cityId,
            size: AppConstants.shared.pageSize,
            adult: data.adults,
            children: data.children,
            rooms: data.noOfRooms,
            checkIn: Utils.time.format(date: data.checkIn, oF: TimeType.ymd),
            checkOut: Utils.time.format(date: data.checkOut, oF: TimeType.ymd),
          );
          final event = GetListHotel(currentPage: 1, param: paramSearch);
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ListHotelBloc()..add(event)),
            ],
            child: Column(
              children: [
                const FilterSort(),
                ListHotels(search: data),
              ],
            ),
          );
        },
      ),
    );
  }
}
