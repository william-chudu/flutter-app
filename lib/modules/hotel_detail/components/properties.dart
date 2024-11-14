part of '../index.dart';

final class Properties extends StatelessWidget {
  const Properties({super.key, required this.hotel, required this.onTap, required this.label});

  final HotelInfoDetail hotel;
  final void Function(String label) onTap;
  final LanguageLabel label;

  @override
  Widget build(BuildContext context) {
    final properties = [
      Pair(label.summary, hotel.propertydetails),
      Pair(label.roomDescription, hotel.motaloaiphong),
      Pair(label.locationNTransport, hotel.gettingthere),
      Pair(label.cuisine, hotel.amthuc),
      Pair(label.entertainment, hotel.giaitri),
    ];

    final propCount = properties.length;
    return SliverList.builder(
      itemCount: properties.length + 5,
      itemBuilder: (context, index) {
        if (index < propCount) {
          final prop = properties[index];
          return HotelProperty(
            label: prop.first,
            content: prop.second,
            seemore: label.seemore,
            onTap: onTap,
          );
        } else if (index == propCount) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TitleProperty(label: label.facilitiesOfHotel),
                const SizedBox(height: 10),
                ...List<Widget>.generate(5, (ix) {
                  return Row(
                    children: [
                      Icon(
                        Icons.check_box_outlined,
                        size: 20,
                        color: Colors.grey[700],
                      ),
                      const SizedBox(width: 10),
                      Text(
                        hotel.facilities[ix].facilityName,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      onTap(label.facilitiesOfHotel);
                    },
                    child: Text(
                      label.seeAllFacilitiesOfHotel,
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (index == propCount + 1) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(height: 40),
                TitleProperty(label: label.map),
                const SizedBox(height: 10),
                Text(
                  hotel.address1,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    MapParam.now.cityId = int.tryParse(hotel.cityid) ?? 0;
                    MapParam.now.hotelIdint = int.tryParse(hotel.hotelidint) ?? 0;
                    MapParam.now.pointerlatitude = hotel.pointerlatitude.trim();
                    MapParam.now.pointerlongtitude = hotel.pointerlongtitude.trim();
                    MapParam.now.hotelName = hotel.hotelname;

                    if (MapParam.now.isValid()) {
                      Navigator.of(context).pushNamed(GoogleMapPage.routeName);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
                          backgroundColor: Colors.red[800],
                          content: Center(
                            child: Text(
                              label.cannotShowMapNow,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Image.network(
                    hotel.mapthumbnail.imgUrl,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                )
              ],
            ),
          );
        } else if (index == propCount + 2) {
          return ExpansionHotelInfo(label: label.regulationAndNote, list: _regulation());
        } else if (index == propCount + 3) {
          return ExpansionHotelInfo(label: label.frequentQuestions, list: hotel.hotelFQA);
        } else {
          final reviewCount = int.tryParse(hotel.reviewcount) ?? 0;
          final reviewRatingTotal = int.tryParse(hotel.reviewratingtotal) ?? 0;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(height: 40),
                TitleProperty(label: label.review),
                const SizedBox(height: 20),
                Center(
                  child: ReviewCount(
                    count: reviewCount,
                    averageReview: (reviewCount == 0 ? 0 : (2 * reviewRatingTotal / reviewCount))
                        .toStringAsFixed(1),
                    isDetailReview: true,
                  ),
                ),
                const SizedBox(height: 20),
                DetailReviewScore(
                  color: Colors.amber,
                  label: label,
                  worthy: hotel.reviewdangtien,
                  location: hotel.reviewvitri,
                  cleaness: hotel.reviewsachse,
                  staff: hotel.reviewnhanvien,
                  room: hotel.reviewphong,
                  food: hotel.reviewdoan,
                ),
                const SizedBox(height: 10),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(HotelReview.routeName);
                    },
                    child: Text(
                      label.seeAllReviews,
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  List<Expansion> _regulation() {
    return [
      Expansion(
        id: 'QD1',
        title: 'Giờ Nhận - Trả Phòng',
        content:
            '''Giờ nhận phòng: <b>${Utils.time.format(date: Utils.time.timeLocale.parse(hotel.checkintime), oF: TimeType.hm)}</b>
            <br/>Giờ trả phòng: <b>${Utils.time.format(date: Utils.time.timeLocale.parse(hotel.checkouttime), oF: TimeType.hm)}</b>''',
      ),
      Expansion(id: 'QD2', title: 'Quy định nhận phòng', content: hotel.checkininstructions),
      Expansion(
        id: 'QD3',
        title: 'Quy định hủy đổi của khách sạn',
        content: hotel.cancellationpolicy,
      ),
      Expansion(
        id: 'QD4',
        title: 'Quy định về trẻ em và giường phụ',
        content: hotel.childrenextrabedpolicy,
      ),
      const Expansion(
        id: 'QD5',
        title: 'Quy định hủy/đổi dịch vụ',
        content:
            '''<p>Phí hủy/đổi của một đặt dịch vụ = mức phí hủy/đổi của khách sạn + mức phí xử lý giao dịch của Chudu24.</p>
            <p>Mức phí hủy/đổi của khách sạn: là mức phí được tính dựa vào điều kiện hủy phòng.</p>
            <p>Mức phí xử lý giao dịch của Chudu24 như sau:</p>
            <ul>
              <li>Đặt dịch vụ dưới 5 triệu: từ 50,000 vnđ đến 2% tổng giá trị dịch vụ.</li>
              <li>Đặt dịch vụ trên 5 triệu: 1,5% tổng giá trị dịch vụ.</li>
              <li>Đặt dịch vụ không được hủy/đổi cần hỗ trợ hủy/đổi: tùy trường hợp, mức phí sẽ được thông báo cho Quý Khách trước khi tiến hành.</li>
            </ul>
          ''',
      ),
      Expansion(id: 'QD6', title: 'Quy định khác', content: hotel.otherpolicy),
    ];
  }
}
