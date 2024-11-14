part of '../index.dart';

final class HotelFacilitiesDetail extends StatelessWidget {
  const HotelFacilitiesDetail({
    super.key,
    required this.hotel,
    required this.title,
    required this.paddingTop,
  });

  final HotelInfoDetail hotel;
  final String title;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    final label = AppConstants.shared.label;
    final tags = <String>[
      label.summary,
      label.roomDescription,
      label.locationNTransport,
      label.cuisine,
      label.entertainment,
      label.facilitiesOfHotel,
    ];
    return DefaultTabController(
      length: tags.length,
      initialIndex: tags.indexOf(title),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            hotel.hotelname,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: TabBar(
              enableFeedback: true,
              dividerHeight: 0,
              indicatorWeight: 5,
              tabAlignment: TabAlignment.start,
              indicatorColor: AppConstants.accent,
              labelColor: AppConstants.accent,
              isScrollable: true,
              tabs: List<Tab>.generate(
                tags.length,
                (index) {
                  return Tab(
                    height: 30,
                    child: Text(
                      tags[index],
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _ItemFacility(content: hotel.propertydetails),
              _ItemFacility(content: hotel.motaloaiphong),
              _ItemFacility(content: hotel.gettingthere),
              _ItemFacility(content: hotel.amthuc),
              _ItemFacility(content: hotel.giaitri),
              _ItemFacility(content: hotel.propertydetails),
            ],
          ),
        ),
      ),
    );
  }
}

final class _ItemFacility extends StatelessWidget {
  const _ItemFacility({required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Html(
        data: content,
        style: {
          '*': Style(fontSize: FontSize(16), padding: HtmlPaddings.zero, margin: Margins.zero),
        },
      ),
    );
  }
}
