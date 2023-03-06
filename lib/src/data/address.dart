class Address {
  /// 市町村ID
  final int cityId;

  /// 都道府県ID
  final int prefectureId;

  /// 市町村名
  final String cityName;

  /// 都道府県名
  final String prefectureName;

  Address({
    required this.cityId,
    required this.prefectureId,
    required this.cityName,
    required this.prefectureName,
  });
}
