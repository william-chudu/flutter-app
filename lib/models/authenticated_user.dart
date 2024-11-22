import 'package:chudu24/enum/index.dart';
import 'package:hive/hive.dart';

import 'memship_account_profile.dart';

part 'authenticated_user.g.dart';

@HiveType(typeId: 1, adapterName: ConstantType.nAthenticatedUser)
final class AuthenticatedUser {
  @HiveField(0)
  final String accountBusinessType;
  @HiveField(1)
  final String accountId;
  @HiveField(2)
  final String accountType;
  @HiveField(3)
  final String accountUser;
  @HiveField(4)
  final int fkLevel;
  @HiveField(5)
  final int? isUpdatePointBusunessType;
  @HiveField(6)
  final String levelName;
  @HiveField(7)
  final MemShipAccountProfile memShipAccountProfile;
  @HiveField(8)
  final String token;
  @HiveField(9)
  final int totalMoney;
  @HiveField(10)
  final int totalMoneyOld;
  @HiveField(11)
  final int totalPoint;

  AuthenticatedUser({
    required this.accountBusinessType,
    required this.accountId,
    required this.accountType,
    required this.accountUser,
    required this.fkLevel,
    required this.isUpdatePointBusunessType,
    required this.levelName,
    required this.memShipAccountProfile,
    required this.token,
    required this.totalMoney,
    required this.totalMoneyOld,
    required this.totalPoint,
  });

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) => AuthenticatedUser(
        accountBusinessType: json["accountBusinessType"],
        accountId: json["accountId"],
        accountType: json["accountType"],
        accountUser: json["accountUser"],
        fkLevel: json["fkLevel"],
        isUpdatePointBusunessType: json["isUpdatePointBusunessType"],
        levelName: json["levelName"],
        memShipAccountProfile: MemShipAccountProfile.fromJson(json["memShipAccountProfile"]),
        token: json["token"],
        totalMoney: json["totalMoney"],
        totalMoneyOld: json["totalMoneyOld"],
        totalPoint: json["totalPoint"],
      );

  Map<String, dynamic> toJson() => {
        "accountBusinessType": accountBusinessType,
        "accountId": accountId,
        "accountType": accountType,
        "accountUser": accountUser,
        "fkLevel": fkLevel,
        "isUpdatePointBusunessType": isUpdatePointBusunessType,
        "levelName": levelName,
        "memShipAccountProfile": memShipAccountProfile.toJson(),
        "token": token,
        "totalMoney": totalMoney,
        "totalMoneyOld": totalMoneyOld,
        "totalPoint": totalPoint,
      };
}
