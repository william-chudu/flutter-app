import 'package:chudu24/enum/index.dart';

final class InfoCartTicket {
  final String type = ConstantType.ticket;
  final String checkIn;
  final int hotelIdInt;
  final String roomTypeId;

  InfoCartTicket({
    required this.checkIn,
    required this.hotelIdInt,
    required this.roomTypeId,
  });

  factory InfoCartTicket.fromJson(Map<String, dynamic> json) => InfoCartTicket(
        checkIn: json['checkIn'],
        hotelIdInt: json['hotelIdInt'],
        roomTypeId: json['roomTypeId'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'checkIn': checkIn,
        'hotelIdInt': hotelIdInt,
        'roomTypeId': roomTypeId,
      };
}
