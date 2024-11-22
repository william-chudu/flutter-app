import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:chudu24/modules/bootstrap/models/address_search.dart';
import 'package:chudu24/modules/city_n_ticket/index.dart';
import 'package:chudu24/modules/home/bloc/international_hotel/international_hotel_bloc.dart';
import 'package:chudu24/modules/home/bloc/travel_guide/travel_guide_bloc.dart';
import 'package:chudu24/modules/hotel_detail/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/promotion_banner/promotion_banner_bloc.dart';
import 'bloc/top_destination/top_destination_bloc.dart';
import 'bloc/top_sale/top_sale_bloc.dart';
import 'components/box_search.dart';
import 'components/copyright.dart';
import 'components/header.dart';
import 'components/international_hotel.dart';
import 'components/promotion_banner.dart';
import 'components/top_destination.dart';
import 'components/top_sale.dart';
import 'components/travel_guide.dart';

final class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  static final Widget screen = MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => PromotionBannerBloc()..add(const GetPromotionBanner()),
      ),
      BlocProvider(
        create: (context) => TopSaleBloc()..add(const GetTopSale()),
      ),
      BlocProvider(
        create: (context) => TopDestinationBloc()..add(const GetTopDestination()),
      ),
      BlocProvider(
        create: (context) => InternationalHotelBloc()..add(const GetInternationalHotel()),
      ),
      BlocProvider(
        create: (context) => TravelGuideBloc()..add(const GetTravelGuide()),
      ),
    ],
    child: const HomeScreen(),
  );
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => screen,
      settings: const RouteSettings(name: routeName),
    );
  }

  const HomeScreen({super.key});

  void onTapItem(BuildContext context, AddressSearch search) {
    context.read<AppSearchBloc>().add(AppSearchEvent(search: search));
    if (search.type == SearchType.city) {
      Navigator.of(context).pushNamed(CityNTicket.routeName);
    } else if (search.type == SearchType.hotel) {
      Navigator.of(context).pushNamed(HotelDetail.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    const h20 = 20.0;
    final isDarkMode = context.isDarkMode;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HeaderHome(),
            const Divider(height: 0),
            Expanded(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  BoxSearch(isDarkMode: isDarkMode),
                  const SizedBox(height: h20),
                  PromotionBanner(isDarkMode: isDarkMode),
                  const SizedBox(height: h20),
                  TopSale(onTapItem: onTapItem, isDarkMode: isDarkMode),
                  const SizedBox(height: h20),
                  TopDestination(onTapItem: onTapItem, isDarkMode: isDarkMode),
                  const SizedBox(height: h20),
                  InternationalHotel(onTapItem: onTapItem, isDarkMode: isDarkMode),
                  const SizedBox(height: h20),
                  TravelGuide(isDarkMode: isDarkMode),
                  const SizedBox(height: 40),
                  const Divider(height: 0),
                  const SizedBox(height: h20),
                  const Copyright(),
                  const SizedBox(height: h20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
