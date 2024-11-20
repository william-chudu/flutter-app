part of '../index.dart';

final class ParamListPoint {
  final String accountId;
  final String token;
  final String platform = 'apps';

  const ParamListPoint({required this.accountId, required this.token});

  Map<String, String> toJson() => {
        'accountId': accountId,
        'token': token,
        'platform': platform,
      };
}
