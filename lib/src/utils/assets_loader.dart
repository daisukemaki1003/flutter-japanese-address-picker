import 'dart:convert';
import 'dart:io';

class AssetsLoader {
  /// 都道府県+市町村データを読み込む
  static Future<List<List>> city() {
    return loadCsvFile("city_seeds.csv");
  }

  /// 都道府県データを読み込む
  static Future<List<List>> prefectures() {
    return loadCsvFile("prefectures_seeds.csv");
  }

  static Stream loadAssetsFile(String path) {
    return File("assets/$path").openRead();
  }

  /// Csv読み込み
  static Future<List<List>> loadCsvFile(String path) async {
    List<List> data = [];

    final decoded = loadAssetsFile("csv/$path").transform(utf8.decoder);

    /// ','で分割したListを[data]に追加
    await decoded.transform(LineSplitter()).listen((line) {
      data.add(line.split(','));
    }).asFuture();

    return Future<List<List>>.value(data);
  }
}
