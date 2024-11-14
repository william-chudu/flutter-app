import 'package:chudu24/enum/index.dart';
import 'package:chudu24/modules/bootstrap/models/app_search.dart';
import 'package:chudu24/utils/index.dart';

final class ParamRoomRate {
  final int hotelIdInt;
  final int adult;
  final int children;
  final int numberOfRoom;
  final String checkIn;
  final String checkOut;
  final String type = 'RATEDETAIL';

  ParamRoomRate({
    required this.hotelIdInt,
    required this.adult,
    required this.children,
    required this.numberOfRoom,
    required this.checkIn,
    required this.checkOut,
  });

  factory ParamRoomRate.fromAppSearch(
    AppSearch s,
    int hotelIdInt,
  ) =>
      ParamRoomRate(
        hotelIdInt: hotelIdInt,
        adult: s.adults,
        children: s.children,
        numberOfRoom: s.noOfRooms,
        checkIn: Utils.time.format(date: s.checkIn, oF: TimeType.ymd),
        checkOut: Utils.time.format(date: s.checkOut, oF: TimeType.ymd),
      );

  Map<String, dynamic> toJson() => {
        "hotelIdInt": hotelIdInt,
        "adult": adult,
        "children": children,
        "numberOfRoom": numberOfRoom,
        "checkIn": checkIn,
        "checkOut": checkOut,
        "type": type,
      };
}
