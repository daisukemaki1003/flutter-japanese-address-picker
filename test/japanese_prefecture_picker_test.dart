import 'package:japanese_prefecture_picker/src/utils/util.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('CSVファイルを読み込めるか？', () async {
      final csv = await CsvLoader.prefectures();
      print(csv);
      expect(csv.length, 47);
    });
  });
}
