import 'fake_address.dart';

class Address {
  /// 都道府県ID
  final int prefectureId;

  /// 市町村ID
  final int cityId;

  Address({
    this.prefectureId = 0,
    this.cityId = -1,
  });

  Address copyWith({int? cityId, int? prefectureId}) {
    return Address(
      cityId: cityId ?? this.cityId,
      prefectureId: prefectureId ?? this.prefectureId,
    );
  }

  Object? _prefectureName() => getPrefectures(this)?['prefecture'];
  String? _cityName() => getCites(this)?[cityId];

  /// 都道府県名
  String get prefecture {
    try {
      return _prefectureName() as String;
    } catch (e) {
      return '未選択';
    }
  }

  /// 市町村名
  String get city {
    try {
      return _cityName() as String;
    } catch (e) {
      return '未選択';
    }
  }
}

Map<String, Object>? getPrefectures(Address address) {
  return test_json_data[address.prefectureId];
}

Map<int, String>? getCites(Address address) {
  return getPrefectures(address)!['cites'] as Map<int, String>;
}

Map<int, String> prefectureIdAndNames(Address address) {
  final Map<int, String> data = {};
  test_json_data.forEach((key, value) {
    data[key] = value['prefecture'] as String;
  });
  return data;
}
