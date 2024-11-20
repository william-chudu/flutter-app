import 'package:chudu24/modules/bottom/index.dart';
import 'package:chudu24/modules/city_n_ticket/index.dart';
import 'package:chudu24/modules/error/index.dart';
import 'package:chudu24/modules/google_map/index.dart';
import 'package:chudu24/modules/home/index.dart';
import 'package:chudu24/modules/hotel_detail/index.dart';
import 'package:chudu24/modules/hotel_review/index.dart';
import 'package:chudu24/modules/international_item/index.dart';
import 'package:chudu24/modules/list_point/index.dart';
import 'package:chudu24/modules/notfound/index.dart';
import 'package:chudu24/modules/search_info/index.dart';
import 'package:chudu24/modules/setting/index.dart';
import 'package:chudu24/modules/shopping_cart/index.dart';
import 'package:chudu24/modules/splash/index.dart';
import 'package:chudu24/modules/top_promotion/index.dart';
import 'package:chudu24/modules/travel_news/index.dart';
import 'package:chudu24/modules/webview/index.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreen.routeName:
        return SplashScreen.route();
      case NotFoundScreen.routeName:
        return NotFoundScreen.route();
      case BottomTabsScreen.routeName:
        return BottomTabsScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case CityNTicket.routeName:
        return CityNTicket.route();
      case HotelDetail.routeName:
        return HotelDetail.route();
      case Setting.routeName:
        return Setting.route();
      case SearchInfo.routeName:
        return SearchInfo.route();
      case GoogleMapPage.routeName:
        return GoogleMapPage.route();
      case HotelReview.routeName:
        return HotelReview.route();
      case TopPromotion.routeName:
        return TopPromotion.route();
      case InternationItem.routeName:
        return InternationItem.route();
      case TravelNews.routeName:
        return TravelNews.route();
      case ShoppingCart.routeName:
        return ShoppingCart.route();
      case ListPoint.routeName:
        return ListPoint.route();
      case Webview.routeName:
        return Webview.route(routeSettings);
      default:
        return ErrorScreen.route();
    }
  }
}
