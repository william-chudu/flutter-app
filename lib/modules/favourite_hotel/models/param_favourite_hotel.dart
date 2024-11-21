part of '../index.dart';

final class ParamFavouriteHotel {
  final String fkAccount;
  final String checkIn;
  final String checkOut;
  final String order = 'createdDate|DESC';

  ParamFavouriteHotel({
    required this.fkAccount,
    required this.checkIn,
    required this.checkOut,
  });

  Map<String, dynamic> toJson() => {
        "fkAccount": fkAccount,
        "checkIn": checkIn,
        "checkOut": checkOut,
        "order": order,
      };
}
