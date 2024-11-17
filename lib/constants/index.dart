import 'package:chudu24/enum/index.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

part 'language.dart';
part 'default_link.dart';

final class AppConstants {
  bool _isEn = false;
  int pageSize = 20;
  static final shared = AppConstants();
  final LanguageForApp _lang = const LanguageForApp();
  LanguageLabel get label => _isEn ? _lang.enLabel : _lang.vnLabel;
  ELocale get locale => _isEn ? ELocale.en : ELocale.vn;
  static DefaultLink link = const DefaultLink();
  static const Color accent = Color(0xFFBF360C);

  void setLanguage([bool isEn = false]) {
    _isEn = isEn;
    if (isEn) {
      initializeDateFormatting('en_US', null);
    } else {
      initializeDateFormatting('vi_VN', null);
    }
  }
}
