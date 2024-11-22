import 'package:chudu24/enum/index.dart';
import 'package:hive/hive.dart';

part 'info_cart_hotel.g.dart';

@HiveType(typeId: 0, adapterName: ConstantType.nHotel)
final class InfoCartHotel {
  @HiveField(0)
  final String checkIn;
  @HiveField(1)
  final String checkOut;
  @HiveField(2)
  final int hotelIdInt;
  @HiveField(3)
  final String roomTypeId;
  @HiveField(4)
  final int noOfRooms;
  @HiveField(5)
  final String roomTypeParentId;
  @HiveField(6)
  final String createdAt = DateTime.now().toString();

  InfoCartHotel({
    required this.checkIn,
    required this.checkOut,
    required this.hotelIdInt,
    required this.roomTypeId,
    required this.roomTypeParentId,
    required this.noOfRooms,
  });

  // factory InfoCartHotel.fromJson(Map<String, dynamic> json) => InfoCartHotel(
  //       checkIn: json['checkIn'],
  //       checkOut: json['checkOut'],
  //       hotelIdInt: json['hotelIdInt'],
  //       roomTypeId: json['roomTypeId'],
  //     );

  // Map<String, dynamic> toJson() => {
  //       'checkIn': checkIn,
  //       'checkOut': checkOut,
  //       'hotelIdInt': hotelIdInt,
  //       'roomTypeId': roomTypeId,
  //     };
}
