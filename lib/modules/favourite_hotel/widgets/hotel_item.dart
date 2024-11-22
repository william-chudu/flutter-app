part of '../index.dart';

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
