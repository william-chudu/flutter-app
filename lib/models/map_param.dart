final class MapParam {
  int hotelIdint;
  int cityId;
  String checkIn;
  String checkOut;
  String pointerlongtitude;
  String pointerlatitude;
  String hotelName;

  MapParam({
    required this.hotelIdint,
    required this.cityId,
    required this.checkIn,
    required this.checkOut,
    required this.pointerlongtitude,
    required this.pointerlatitude,
    this.hotelName = 'Google Map',
  });

  bool isValid() {
    if (hotelIdint <= 0) {
      return false;
    }

    if (cityId <= 0) {
      return false;
    }

    final now = DateTime.now();
    final today = (DateTime(now.year, now.month, now.day));
    if (DateTime.parse(checkIn).isBefore(today)) {
      return false;
    }

    if (DateTime.parse(checkOut).isBefore(today)) {
      return false;
    }

    if (pointerlongtitude.isEmpty) {
      return false;
    }

    if (pointerlatitude.isEmpty) {
      return false;
    }
    return true;
  }

  static MapParam now = MapParam(
    hotelIdint: 0,
    cityId: 0,
    checkIn: '',
    checkOut: '',
    pointerlongtitude: '',
    pointerlatitude: '',
  );

  MapParam copyWith({
    int? hotelIdint,
    int? cityId,
    String? checkIn,
    String? checkOut,
    String? pointerlongtitude,
    String? pointerlatitude,
  }) =>
      MapParam(
        hotelIdint: hotelIdint ?? this.hotelIdint,
        cityId: cityId ?? this.cityId,
        checkIn: checkIn ?? this.checkIn,
        checkOut: checkOut ?? this.checkOut,
        pointerlongtitude: pointerlongtitude ?? this.pointerlongtitude,
        pointerlatitude: pointerlatitude ?? this.pointerlatitude,
      );

  Map<String, dynamic> toJson() => {
        "hotelIdint": hotelIdint,
        "cityId": cityId,
        "pointerlongtitude": pointerlongtitude,
        "pointerlatitude": pointerlatitude,
        'checkIn': checkIn,
        'checkOut': checkIn,
      };
}
