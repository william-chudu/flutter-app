import 'package:chudu24/components/hotel_list_tags.dart';
import 'package:chudu24/components/money.dart';
import 'package:chudu24/components/phone.dart';
import 'package:chudu24/components/review_count.dart';
import 'package:chudu24/components/star.dart';
import 'package:chudu24/components/xnn.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:chudu24/models/authenticated_user.dart';
import 'package:chudu24/models/hotel_tag.dart';
import 'package:chudu24/modules/bootstrap/bloc/app_search/app_search_bloc.dart';
import 'package:chudu24/modules/bootstrap/bloc/authentication/authentication_bloc.dart';
import 'package:chudu24/modules/bootstrap/models/address_search.dart';
import 'package:chudu24/modules/city_n_ticket/widgets/hotel_thumbnail.dart';
import 'package:chudu24/modules/favourite_hotel/bloc/favourite_hotel/favourite_hotel_bloc.dart';
import 'package:chudu24/modules/hotel_detail/index.dart';
import 'package:chudu24/modules/not_login/index.dart';
import 'package:chudu24/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'protocols/redirect_hotel.dart';

part 'models/param_favourite_hotel.dart';
part 'models/item_fav_hotel.dart';

final class FavouriteHotel extends StatelessWidget {
  static const String routeName = '/favourite-hotel';
  static final Widget screen = BlocBuilder<AuthenticationBloc, AuthenticationState>(
    builder: (context, state) {
      if (state.user == null) {
        return const NotLogin();
      }
      final user = state.user as AuthenticatedUser;
      return FavouriteHotel(
        accountId: user.accountId,
      );
    },
  );
  static Route route() {
    return MaterialPageRoute(
      builder: (BuildContext context) => screen,
      settings: const RouteSettings(name: routeName),
    );
  }

  const FavouriteHotel({super.key, required this.accountId});

  final String accountId;

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    final size = MediaQuery.sizeOf(context);
    final width = size.width - 40;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          label.favorite,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<AppSearchBloc, AppSearchState>(
        builder: (context, state) {
          final param = ParamFavouriteHotel(
            fkAccount: accountId,
            checkIn: Utils.time.format(date: state.appSearch.checkIn, oF: TimeType.ymd),
            checkOut: Utils.time.format(date: state.appSearch.checkOut, oF: TimeType.ymd),
          );
          return BlocProvider(
            create: (context) => FavouriteHotelBloc()..add(GetFavouriteHotel(param: param)),
            child: SafeArea(
              child: RedirectHotel(
                onTap: (AddressSearch address) {
                  final search = state.appSearch.copyWith(search: address);
                  context.read<AppSearchBloc>().add(AppSearchEvent.fromModel(search));
                  Navigator.of(context).pushNamed(HotelDetail.routeName);
                },
                child: BlocBuilder<FavouriteHotelBloc, FavouriteHotelState>(
                  builder: (ctxBuilder, state) {
                    return Utils.w(state.status) ??
                        ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                          itemCount: state.hotels.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 20),
                          itemBuilder: (_, index) {
                            final hotel = state.hotels[index];
                            return HotelItem(hotel: hotel, width: width);
                          },
                        );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

final class HotelItem extends StatefulWidget {
  const HotelItem({
    super.key,
    required this.hotel,
    required this.width,
  });

  final ItemFavHotel hotel;
  final double width;

  @override
  State<HotelItem> createState() => _HotelItemState();
}

class _HotelItemState extends State<HotelItem> {
  double _height = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((d) {
      setState(() {
        _height = context.size?.height ?? 0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotel;
    final width = widget.width;

    return GestureDetector(
      onTap: () {
        final address = AddressSearch(
          id: int.tryParse(hotel.hotelidint) ?? 0,
          title: hotel.hotelname,
          type: SearchType.hotel,
        );
        RedirectHotel.of(context)?.onTap(address);
      },
      child: Row(
        key: Key(hotel.hotelid),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HotelThumbnail(thumbnail: hotel.thumbnail.imgUrl, width: width, height: _height),
          Expanded(
            child: Container(
              color: Colors.white54,
              width: width * 3 / 5 - 1,
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.hotelname,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StarRating(star: int.tryParse(hotel.starrating) ?? 0),
                        const SizedBox(width: 10),
                        ReviewCount(
                          fontSize: 12,
                          count: int.tryParse(hotel.reviewcount) ?? 0,
                          averageReview: '${(int.tryParse(hotel.starrating) ?? 0) * 2}',
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  HotelListTags(
                    tags: hotel.hotelTags,
                    isColumn: true,
                  ),
                  const SizedBox(height: 10),
                  hotel.minRateHotel > 0
                      ? MoneyWidget(money: hotel.minRateHotel)
                      : const PhoneWidget(fontSize: 15),
                  const SizedBox(height: 5),
                  const XnnWidget(isXNN: false),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
