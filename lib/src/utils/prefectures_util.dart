import 'package:japanese_prefecture_picker/src/utils/assets_loader.dart';

/// 市町村データをMapデータに変換する
/// [key]は都市コード
Future<Map<int, List<int>>> convertCitiesToMapIds() async {
  final Map<int, List<int>> data = {};

  final prefectures = await AssetsLoader.prefectures();
  final cities = await AssetsLoader.cities();

  /// [prefId] 都道府県ID
  /// [cityId] 市町村ID
  /// 都道府県名が一致した市町村を同一の都道府県IDで保存する。
  /// 返り値の市町村IDは次回市町村データを検索する際に利用する。
  int addCityId(int prefId, int cityId) {
    if (cities.length <= cityId) return cityId;

    /// 都道府県名が一致しなかったら市町村IDを返す。
    if (cities[cityId][0] != prefectures[prefId][0]) return cityId;

    /// 都道府県名が一致したら再帰し、次の[cityId]で都道府県名が一致するデータを検索する。
    data[prefId] = [...?data[prefId], cityId];
    return addCityId(prefId, cityId + 1);
  }

  int cityId = 0;
  for (var pref in prefectures) {
    cityId = addCityId(prefectures.indexOf(pref), cityId);
  }

  return data;
}
