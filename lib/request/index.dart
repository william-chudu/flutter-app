import 'dart:convert';
import 'dart:io';

import 'package:chudu24/constants/index.dart';
import 'package:chudu24/extensions/exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

final class _ApiClientEnv {
  static const logging = true;
}

class ApiClient extends http.BaseClient {
  final String host = AppConstants.link.apin;
  static final shared = ApiClient();
  final http.Client _client = http.Client();

  static bool isNotOk(dynamic data) {
    if (data == false) {
      return false;
    }
    if (data == 2000) {
      return false;
    }
    return true;
  }

  Future<Response> mGet(String path, [Map<String, String>? query]) async {
    _logRequest(path, query);
    final uri = Uri.https(host, path, query);
    return await _client.get(uri);
  }

  Future<Response> mPost(String path, [Map<String, dynamic>? data]) async {
    try {
      _logRequest(path, data);
      final uri = Uri.https(host, path);
      return await _client.post(
        uri,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: data != null ? jsonEncode(data) : null,
        encoding: Encoding.getByName('utf-8'),
      );
    } on Exception catch (e) {
      e.pError();
      return http.Response('', 404);
    }
  }

  void _logRequest(String path, [Map<String, dynamic>? data]) {
    if (!_ApiClientEnv.logging || !kDebugMode) {
      return;
    }
    if (kDebugMode) {
      final str = StringBuffer('{');
      str.write('\n     path: ');
      str.write(path);
      if (data != null) {
        str.write('\n');
        str.write('     data: ');
        str.write(data);
      }

      str.write('\n}');
      print(str);
    }
  }

  void dispose() {
    _client.close();
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    return _client.send(request);
  }
}
