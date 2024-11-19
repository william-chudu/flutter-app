import 'dart:io';

import 'package:chudu24/utils/index.dart';

final class ParamSignIn {
  final String username;
  final String password;

  const ParamSignIn({required this.username, required this.password});

  Future<Map<String, dynamic>> toJson() async {
    const hash = r'XbKT$Qa6MIAH8z0AxhbJNtLj9U7RQ%Ro';
    final map = <String, dynamic>{};
    map['username'] = username;
    map['otp'] = '123';
    map['ip'] = '192.168.1.194';
    map['connectId'] = 'memberchudu24';
    map['platform'] = 'apps';
    map['memberLevel'] = 1;
    map['levelName'] = 'C0';
    map['fkAccount'] = '';
    map['platformOS'] = Platform.isIOS ? 'ios' : 'android';
    map['password'] = Utils.string.genMd5(password + hash);
    map['hash'] = Utils.string.genMd5('match24hotelchudu$username');
    map['memberInfo'] = {
      'accountBusinessType': '',
      'accountId': '',
      'accountType': '',
      'accountUser': '',
      'fkLevel': 1,
      'levelName': 'C0',
      'totalMoney': 0,
      'fullName': '',
      'email': '',
      'phone': '',
      'totalPoint': 0,
    };
    map['deviceId'] = await Utils.device.getId();
    map['token'] = Utils.string.genMd5(map.keys.map((key) => '$key=${map[key]}').join('&'));
    return map;
  }
}
