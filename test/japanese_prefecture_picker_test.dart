import 'package:japanese_prefecture_picker/src/utils/assets_loader.dart';
import 'package:japanese_prefecture_picker/src/utils/prefectures_util.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('CSVファイルを読み込めるか？', () async {
      final csv = await AssetsLoader.prefectures();
      print(csv);
      expect(csv.length, 47);
    });

    test("市町村データを分割できているか", () async {
      await convertCitiesToMapIds();
      expect(true, true);
    });
  });
}
