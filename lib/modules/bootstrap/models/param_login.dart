final class ParamLogin {
  final String username;
  final String password;
  final String connectId = 'v2UpdateConnectCHudu';
  final String hash;
  final String otp = '123';

  ParamLogin({
    required this.username,
    required this.password,
    required this.hash,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "connectId": connectId,
        "hash": hash,
        "otp": otp,
      };
}
