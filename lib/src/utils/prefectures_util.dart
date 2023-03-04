import 'package:japanese_prefecture_picker/src/utils/assets_loader.dart';

/// 市町村データをMapデータに変換する
/// [key]は都市コード
///
/// final map = {
///   '都市コード': [
///     '市町村コード',
///     '市町村コード',
///     '市町村コード',
///     '市町村コード',
///   ],
///   '都市コード2': [
///     '市町村コード',
///     '市町村コード',
///     '市町村コード',
///     '市町村コード',
///   ]
/// };
///
Future<Map<int, List<int>>> convertCitiesToMapIds() async {
  final Map<int, List<int>> data = {};

  final prefectures = await AssetsLoader.prefectures().then((v) => v.asMap());
  final cities = await AssetsLoader.cities().then((v) => v.asMap());

  int addId(int prefectureKey, int cityKey) {
    if (cities[cityKey]?[0] != prefectures[prefectureKey]?[0]) return cityKey;
    data[prefectureKey] = [...?data[prefectureKey], cityKey];
    return addId(prefectureKey, cityKey + 1);
  }

  int index = 0;
  for (var prefecture in prefectures.keys) {
    index = addId(prefecture, index);
  }

  return data;
}
