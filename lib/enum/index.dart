enum Progress { initial, loading, loaded, error, added, delete, update, exceed }

enum Language { vn, en }

final class ConstantType {
  const ConstantType();
  static const hotel = 'CartHotelAdapter';
  static const city = 'City';
  static const ticket = 'Ticket';
  static const ticketitem = 'Ticketitem';
}

enum SearchType { hotel, city, ticket, ticketitem }

enum TimeType {
  dmyhm('dd-MM-yyyy HH:mm'),
  dmy('dd-MM-yyyy'),
  dMY('dd/MM/yyyy'),
  ymd('yyyy-MM-dd'),
  hm('HH:mm'),
  edm('EEE, dd/MM'),
  dM('dd/MM'),
  edmy('EEE, dd-MM-yyyy');

  const TimeType(this._f);
  final String _f;
  String get value => _f;
}

enum ELocale {
  en('en_US'),
  vn('vi_VN');

  const ELocale(this._lo);
  final String _lo;

  String get value => _lo;
}
