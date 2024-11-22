import 'package:chudu24/components/html_box.dart';
import 'package:chudu24/components/image_builder.dart';
import 'package:chudu24/components/tabbar_header.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/extensions/list.dart';
import 'package:chudu24/models/room_include.dart';
import 'package:chudu24/modules/home/bloc/top_sale/top_sale_bloc.dart';
import 'package:chudu24/modules/home/models/top_sale.dart';
import 'package:chudu24/modules/top_promotion/bloc/detail_promotion/detail_promotion_bloc.dart';
import 'package:chudu24/modules/top_promotion/bloc/other_promotion/other_promotion_bloc.dart';
import 'package:chudu24/modules/webview/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers.dart';

part 'models/param_detail_promotion.dart';
part 'models/detail_promotion.dart';

part 'widgets/box_promotion.dart';

part 'modals/modal_detail_promotion.dart';

part 'components/other_promotions.dart';
part 'components/top_sales.dart';

final class TopPromotion extends StatelessWidget {
  static const String routeName = '/top-promotion';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TopSaleBloc()..add(const GetTopSale()),
          ),
          BlocProvider(
            create: (context) => OtherPromotionBloc()..add(const GetOtherPromotion()),
          ),
        ],
        child: const TopPromotion(),
      ),
      settings: const RouteSettings(name: routeName),
    );
  }

  const TopPromotion({super.key});

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    final isDarkMode = context.isDarkMode;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            label.topPromotion,
            style: context.text.displayMedium,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: TabbarHeader(labels: [label.topPromotion, label.otherPromotions]),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              TopSales(label: label, isDarkMode: isDarkMode),
              OtherPromotions(label: label, isDarkMode: isDarkMode),
            ],
          ),
        ),
      ),
    );
  }
}
