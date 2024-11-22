import 'package:chudu24/components/image_builder.dart';
import 'package:chudu24/components/loading.dart';
import 'package:chudu24/components/tabbar_header.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/extensions/list.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:chudu24/models/header_list_items.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:chudu24/modules/bootstrap/models/address_search.dart';
import 'package:chudu24/modules/city_n_ticket/index.dart';
import 'package:chudu24/modules/international_item/bloc/international_item/international_item_bloc.dart';
import 'package:chudu24/modules/travel_news/index.dart';
import 'package:chudu24/modules/webview/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers.dart';

part 'models/international_element.dart';

part 'widgets/title.dart';

part 'components/popular_choices.dart';
part 'components/top_destinations.dart';
part 'components/list_travel_news.dart';

final class InternationItem extends StatelessWidget {
  static const String routeName = '/international-item';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => BlocProvider(
        create: (context) => InternationalItemBloc()..add(const GetInternationalElements()),
        child: const InternationItem(),
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const InternationItem({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    final isDarkMode = context.isDarkMode;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            label.internationalHotel,
            style: context.text.displayMedium,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: TabbarHeader(
              textStyle: context.text.titleMedium,
              labels: [
                label.topDestination,
                label.popularChoices,
                label.travelNews,
              ],
            ),
          ),
        ),
        body: BlocBuilder<AppSearchBloc, AppSearchState>(
          builder: (_, state) {
            void onTapItem(InternationalElement item) {
              context.read<AppSearchBloc>().add(AppSearchEvent.fromModel(state.appSearch.copyWith(
                    search: AddressSearch(
                      id: item.cityId ?? 0,
                      title: item.tieuDe,
                      type: SearchType.city,
                    ),
                  )));
              Navigator.of(context).pushNamed(CityNTicket.routeName);
            }

            return SafeArea(
              child: TabBarView(
                children: [
                  TopDestinations(onTapItem: onTapItem, isDarkMode: isDarkMode),
                  PopularChoices(onTapItem: onTapItem, isDarkMode: isDarkMode),
                  ListTravelNews(label: label, isDarkMode: isDarkMode),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
