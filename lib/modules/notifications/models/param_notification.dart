part of '../index.dart';

final class ParamNotification {
  final int limit = 20;
  final int offset = 0;
  final String? accountId;

  const ParamNotification({this.accountId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {
      'limit': limit,
      'offset': offset,
    };

    if (accountId != null) {
      map['accountId'] = accountId;
    }

    return map;
  }
}
