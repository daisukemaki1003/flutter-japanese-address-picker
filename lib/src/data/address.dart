class Address {
  /// 市町村ID
  final int cityId;

  /// 都道府県ID
  final int prefectureId;

  // /// 市町村名
  // final String cityName;

  // /// 都道府県名
  // final String prefectureName;

  Address({
    this.cityId = 0,
    this.prefectureId = 0,
    // required this.cityName,
    // required this.prefectureName,
  });

  Address copyWith({int? cityId, int? prefectureId}) {
    return Address(
      cityId: cityId ?? this.cityId,
      prefectureId: prefectureId ?? this.prefectureId,
    );
  }

  cityName() {}
  prefectureName() {}
}
