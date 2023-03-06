import 'package:japanese_prefecture_picker/src/data/address.dart';
import 'package:japanese_prefecture_picker/src/data/fake_address.dart';

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
