import 'package:japanese_prefecture_picker/src/utils/address_util.dart';

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

  /// 都道府県名
  String get prefecture {
    try {
      return getPrefectures(this)?['prefecture'] as String;
    } catch (e) {
      return '未選択';
    }
  }

  /// 市町村名
  String get city {
    try {
      return getCites(this)?[cityId] as String;
    } catch (e) {
      return '未選択';
    }
  }
}
