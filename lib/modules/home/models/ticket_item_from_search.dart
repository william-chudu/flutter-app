import 'package:chudu24/enum/index.dart';
import 'package:chudu24/modules/home/models/search_type.dart';

final class TicketItemFromSearch extends DataSearchType {
  final int idint;
  final String serviceName;
  final String serviceNameTextId;
  final String? address;

  TicketItemFromSearch({
    required super.type,
    required this.idint,
    required this.serviceName,
    required this.serviceNameTextId,
    required this.address,
  });

  factory TicketItemFromSearch.fromJson(Map<String, dynamic> json) => TicketItemFromSearch(
        type: SearchType.ticketitem,
        idint: json["idint"],
        serviceName: json["serviceName"],
        serviceNameTextId: json["serviceNameTextId"],
        address: json["address"],
      );
}
