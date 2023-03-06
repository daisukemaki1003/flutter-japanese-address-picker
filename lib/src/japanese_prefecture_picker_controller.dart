import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/src/data/address.dart';
import 'package:japanese_prefecture_picker/src/data/fake_address.dart';

class JapanesePrefecturePickerController extends StatefulWidget {
  const JapanesePrefecturePickerController({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(
    Address address,
    Function(Address) onChange,
    Map<int, String> prefectures,
    Map<int, String> cites,
  ) builder;

  @override
  State<StatefulWidget> createState() =>
      _JapanesePrefecturePickerControllerState();
}

class _JapanesePrefecturePickerControllerState
    extends State<JapanesePrefecturePickerController> {
  /// 選択されたアドレス
  Address address = Address();

  /// 表示する都道府県データ
  Map<int, String> prefectures = {};

  /// 表示する市町村データ
  Map<int, String> cites = {};

  changeAddress(newAddress) {
    setState(() => address = newAddress);
  }

  @override
  void initState() {
    /// 都道府県データを初期化
    json.forEach((key, value) {
      prefectures[key] = value['prefecture'] as String;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// 選択された都道府県IDに応じて表示する市町村データを生成します。
    cites = json[address.prefectureId]!['cites'] as Map<int, String>;

    return widget.builder(
      address,
      changeAddress,
      prefectures,
      cites,
    );
  }
}
