import 'package:chudu24/components/money.dart';
import 'package:chudu24/components/phone.dart';
import 'package:chudu24/components/review_count.dart';
import 'package:chudu24/components/star.dart';
import 'package:chudu24/components/xnn.dart';
import 'package:chudu24/enum/index.dart';
import 'package:chudu24/extensions/build_context.dart';
import 'package:chudu24/extensions/string.dart';
import 'package:chudu24/modules/bootstrap/models/address_search.dart';
import 'package:chudu24/modules/city_n_ticket/models/hotel_info.dart';
import 'package:chudu24/components/hotel_list_tags.dart';
import 'package:chudu24/modules/city_n_ticket/widgets/hotel_thumbnail.dart';
import 'package:flutter/material.dart';

class BoxHotelItem extends StatefulWidget {
  const BoxHotelItem({
    super.key,
    required this.width,
    required this.hotel,
    required this.onTap,
  });

  final double width;
  final HotelInfo hotel;
  final void Function(AddressSearch s) onTap;

  @override
  State<BoxHotelItem> createState() => _BoxHotelItemState();
}

class _BoxHotelItemState extends State<BoxHotelItem> {
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
    final averageReview = hotel.reviewcount == 0
        ? '0'
        : (hotel.reviewratingtotal / hotel.reviewcount).toStringAsFixed(1);
    return GestureDetector(
      onTap: () {
        final address = AddressSearch(
          id: hotel.hotelidint,
          title: hotel.hotelname,
          type: SearchType.hotel,
        );
        widget.onTap(address);
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
                    style: context.text.titleMedium,
                  ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        StarRating(star: hotel.starrating),
                        const SizedBox(width: 10),
                        ReviewCount(count: hotel.reviewcount, averageReview: averageReview)
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
                  XnnWidget(isXNN: hotel.hotelSupplierList?.isNotEmpty == true),
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
