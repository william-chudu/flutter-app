import 'dart:async';

import 'package:chudu24/components/button.dart';
import 'package:chudu24/components/button_login.dart';
import 'package:chudu24/components/detail_review_score.dart';
import 'package:chudu24/components/header_modal.dart';
import 'package:chudu24/components/hotel_list_tags.dart';
import 'package:chudu24/components/icon_shopping_cart.dart';
import 'package:chudu24/components/image_builder.dart';
import 'package:chudu24/components/image_review.dart';
import 'package:chudu24/components/loading.dart';
import 'package:chudu24/components/money.dart';
import 'package:chudu24/components/review_count.dart';
import 'package:chudu24/components/star.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:chudu24/models/hotel_image.dart';
import 'package:chudu24/models/hotel_info_detail.dart';
import 'package:chudu24/models/info_cart_hotel.dart';
import 'package:chudu24/models/pair.dart';
import 'package:chudu24/models/param_room_rate.dart';
import 'package:chudu24/models/item_room_rate.dart';
import 'package:chudu24/models/room_include.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:chudu24/modules/google_map/index.dart';
import 'package:chudu24/models/map_param.dart';
import 'package:chudu24/modules/hotel_review/index.dart';
import 'package:chudu24/modules/notfound/index.dart';
import 'package:chudu24/modules/search_info/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'bloc/hotel_info_detail/hotel_info_detail_bloc.dart';
import 'bloc/hotel_room_rate/hotel_room_rate_bloc.dart';

part 'protocols/add_to_cart_protocol.dart';

part 'models/deal_opening.dart';
part 'models/facility.dart';
part 'models/expansion.dart';
part 'models/map_info.dart';

part 'widgets/title_property.dart';
part 'widgets/custom_appbar_fab.dart';
part 'widgets/hotel_property.dart';
part 'widgets/sliver_fab.dart';
part 'widgets/expansion_hotel_info.dart';
part 'widgets/item_room_box_close.dart';
part 'widgets/item_room_box_open.dart';
part 'widgets/item_room_box.dart';

part 'modals/modal_deal.dart';
part 'modals/modal_room_information.dart';
part 'components/hotel_title.dart';
part 'components/list_of_rooms.dart';
part 'components/opening_deal.dart';
part 'components/scale_header.dart';
part 'components/hotel_facilities_detail.dart';
part 'components/properties.dart';
part 'components/room_selection.dart';

final class HotelDetail extends StatelessWidget {
  static const String routeName = '/hotel-detail';
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => const HotelDetail(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const HotelDetail({super.key});

  void redirect(BuildContext context, HotelInfoDetail hotel, String label) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) {
        return HotelFacilitiesDetail(
          hotel: hotel,
          title: label,
          paddingTop: MediaQuery.viewPaddingOf(context).top,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSearchBloc, AppSearchState>(
      buildWhen: (prev, cur) {
        return prev.appSearch.search?.id != cur.appSearch.search?.id;
      },
      builder: (context, searchState) {
        final hotelIdInt = searchState.appSearch.search?.id;
        if (hotelIdInt == null) {
          if (hotelIdInt == null) {
            Navigator.pop(context);
            return const NotFoundScreen();
          }
        }
        MapParam.now.checkIn = Utils.time.format(
          date: searchState.appSearch.checkIn,
          oF: TimeType.ymd,
        );
        MapParam.now.checkOut = Utils.time.format(
          date: searchState.appSearch.checkOut,
          oF: TimeType.ymd,
        );
        const expandedHeight = 350.0;
        const floatingHeight = 210.0;
        final top = (floatingHeight / 3).roundToDouble();

        return AddToCartProtocol(
          onTapAddToCart: (roomTypeId, roomTypeParentId, noOfRooms) {
            final info = searchState.appSearch;
            final itemCart = InfoCartHotel(
                checkIn: Utils.time.format(date: info.checkIn, oF: TimeType.ymd),
                checkOut: Utils.time.format(date: info.checkOut, oF: TimeType.ymd),
                roomTypeId: roomTypeId,
                roomTypeParentId: roomTypeParentId,
                hotelIdInt: hotelIdInt,
                noOfRooms: noOfRooms);
            context.read<ShoppingCartBloc>().add(AddNewItemCart(item: itemCart));
          },
          child: Scaffold(
            body: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => HotelInfoDetailBloc()
                    ..add(
                      GetHotelInfoDetail(hotelIdInt: hotelIdInt),
                    ),
                ),
              ],
              child: BlocBuilder<HotelInfoDetailBloc, HotelInfoDetailState>(
                builder: (context, state) {
                  if (state.status == Progress.error) {
                    return const NotFoundScreen();
                  }
                  if (state.status == Progress.initial || state.status == Progress.loading) {
                    return const LoadingWidget();
                  }
                  final hotel = state.info.first;
                  final label = AppConstants.shared.label;

                  return Builder(builder: (context) {
                    void onTapSeemore(String label) {
                      redirect(context, hotel, label);
                    }

                    void selectDateRange(AppSearchEvent event) {
                      context.read<AppSearchBloc>().add(event);
                    }

                    final paddingTop = MediaQuery.viewPaddingOf(context).top;

                    void showPhotoAlbum(List<HotelImage> photos) {
                      ImageReview.showImageReview(
                        context: context,
                        photos: photos,
                        paddingTop: paddingTop + kToolbarHeight,
                        hasAppbar: false,
                        isFocusing: false,
                      );
                    }

                    return SafeArea(
                      top: false,
                      child: SliverFab(
                        floatingHeight: floatingHeight,
                        expandedHeight: expandedHeight,
                        floatingWidgetPosition: FloatingPosition(top: -top, right: 20, left: 20),
                        floatingWidget: HotelTitle(hotel: hotel),
                        slivers: [
                          ScaleHeader(imageUrl: hotel.thumbnail, expandedHeight: expandedHeight),
                          OpeningDeal(
                            heightFromTop: floatingHeight - top + 30,
                            deals: hotel.deals,
                          ),
                          RoomSelection(label: label, onSelectDate: selectDateRange),
                          ListOfRooms(
                            floatingHeight: floatingHeight,
                            top: top,
                            hasConsultation: (int.tryParse(hotel.starrating) ?? 0) > 3,
                            label: label,
                            onTapAlbum: showPhotoAlbum,
                          ),
                          Properties(hotel: hotel, onTap: onTapSeemore, label: label),
                        ],
                      ),
                    );
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
