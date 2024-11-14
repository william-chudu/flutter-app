import 'package:flutter/foundation.dart';

extension ErrorException on Exception {
  void pError() {
    if (kDebugMode) {
      print('[ERROR-EXCEPTION]: ${toString()}');
    }
  }
}
