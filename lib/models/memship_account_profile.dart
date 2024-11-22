import 'package:chudu24/enum/index.dart';
import 'package:hive/hive.dart';

part 'memship_account_profile.g.dart';

@HiveType(typeId: 2, adapterName: ConstantType.nMemshipAccountProfile)
final class MemShipAccountProfile {
  @HiveField(0)
  final String companyAddress;
  @HiveField(1)
  final String? companyMst;
  @HiveField(2)
  final String companyName;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String fkAccount;
  @HiveField(5)
  final String fullName;
  @HiveField(6)
  final int id;
  @HiveField(7)
  final int noApplyMst;
  @HiveField(8)
  final String phone;

  MemShipAccountProfile({
    required this.companyAddress,
    required this.companyMst,
    required this.companyName,
    required this.email,
    required this.fkAccount,
    required this.fullName,
    required this.id,
    required this.noApplyMst,
    required this.phone,
  });

  factory MemShipAccountProfile.fromJson(Map<String, dynamic> json) => MemShipAccountProfile(
        companyAddress: json["companyAddress"],
        companyMst: json["companyMst"],
        companyName: json["companyName"],
        email: json["email"],
        fkAccount: json["fkAccount"],
        fullName: json["fullName"],
        id: json["id"],
        noApplyMst: json["noApplyMst"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "companyAddress": companyAddress,
        "companyMst": companyMst,
        "companyName": companyName,
        "email": email,
        "fkAccount": fkAccount,
        "fullName": fullName,
        "id": id,
        "noApplyMst": noApplyMst,
        "phone": phone,
      };
}
