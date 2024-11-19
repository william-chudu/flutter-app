import 'dart:convert';
import 'dart:io';

import 'package:chudu24/components/loading.dart';
import 'package:chudu24/constants/index.dart';
import 'package:chudu24/enum/index.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

final class Utils {
  static final time = Datetime();
  static final money = Currency();
  static const string = StringUtil();
  static const device = DeviceInfo();
  static const toast = ToastNotification();

  static Widget? w(Progress status) {
    if (status == Progress.initial || status == Progress.loading) {
      return const LoadingWidget();
    }
    if (status == Progress.error) {
      return const SizedBox.shrink();
    }
    return null;
  }
}

final class ToastNotification {
  const ToastNotification();

  void done(String msg, [ToastGravity gravity = ToastGravity.TOP]) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.green,
      gravity: gravity,
      timeInSecForIosWeb: 2,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
    );
  }

  void warning(String msg, [ToastGravity gravity = ToastGravity.TOP]) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.orange,
      gravity: gravity,
      timeInSecForIosWeb: 2,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
    );
  }

  void error(String msg, [ToastGravity gravity = ToastGravity.TOP]) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: Colors.red,
      gravity: gravity,
      timeInSecForIosWeb: 2,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
    );
  }
}

final class DeviceInfo {
  const DeviceInfo();
  Future<String> getId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor ?? '';
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    } else {
      final info = await deviceInfo.webBrowserInfo;
      return info.product ?? '';
    }
  }
}

final class Datetime {
  final DateFormat timeLocale = DateFormat("EEE MMM dd yyyy HH:mm:ss 'GMT'Z");

  String format({
    String? str,
    DateTime? date,
    TimeType oF = TimeType.dmy,
  }) {
    final dateFormat = DateFormat(oF.value, AppConstants.shared.locale.value);

    if (str != null) {
      return dateFormat.format(DateTime.parse(str));
    }
    return dateFormat.format(date ?? DateTime.now());
  }

  int count(DateTime a, DateTime b) {
    return b.difference(a).inDays;
  }
}

final class Currency {
  final currency = NumberFormat.currency(locale: 'vi_VN', symbol: '');

  String money(int mn) {
    return currency.format(mn / 1000).trim();
  }
}

final class StringUtil {
  final String _numberPattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  const StringUtil();
  bool isValidString(String? str) {
    if (str == null) {
      return false;
    }
    return str.trim().isNotEmpty;
  }

  String placeholder({lines = 2}) {
    return List.generate(lines * 3, (i) => 'placeholder$i').join('');
  }

  String genMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  String? validateMobile(String? value) {
    if (value == null) {
      return 'Please enter mobile number';
    }
    RegExp regExp = RegExp(_numberPattern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  String subHtml(String html, [int count = 50, bool hasEllipsis = true]) {
    final reg = RegExp('/</?[^>]+(>|\$)/g');
    final arrTag = reg.allMatches(html);
    final htmlReplace = html.replaceAll(reg, ' [TAG] ').replaceAll(RegExp('/\n/g'), ' [ENTER] ');
    final arrWords = List<String>.empty(growable: true);
    int ixWord = 0;
    int ixTag = 0;
    final arrHtml = htmlReplace.split(' ');
    for (String word in arrHtml) {
      if (ixWord > count) {
        if (hasEllipsis) {
          arrWords.add('...');
        }
        break;
      }
      if (word.trim().isNotEmpty) {
        if (word == '[ENTER]') {
          arrWords.add('\n');
        } else if (word == '[TAG]') {
          arrWords.add(arrTag.elementAt(ixTag).input);
        } else {
          arrWords.add('$word ');
          ixWord++;
        }
      }
    }
    return arrWords.join('');
  }
}
