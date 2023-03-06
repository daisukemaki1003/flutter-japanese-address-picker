import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/src/data/address.dart';
import 'package:japanese_prefecture_picker/src/data/fake_address.dart';
import 'package:japanese_prefecture_picker/src/utils/address_util.dart';

class JapanesePrefecturePickerController extends StatefulWidget {
  const JapanesePrefecturePickerController({
    Key? key,
    required this.builder,
  }) : super(key: key);

  /// [address]選択中のアドレス
  /// [prefectures]表示する都道府県データ
  /// [cites]表示する市町村データ
  ///
  /// [onChange]アドレスを更新する関数
  /// 引数には新たに選択したアドレスデータが入力される
  final Widget Function(
    Address address,
    Map<int, String> prefectures,
    Map<int, String> cites,
    void Function(Address) onChange,
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

  changeAddress(Address newAddress) {
    /// 選択された都道府県IDに応じて表示する市町村データを生成します。
    if (address.prefectureId != newAddress.prefectureId) {
      cites = addUnselectedItems(getCites(newAddress)!);
    }

    /// アドレスデータを更新
    setState(() => address = newAddress);
  }

  @override
  void initState() {
    prefectures = prefectureIdAndNames(address);
    cites = addUnselectedItems(getCites(address)!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(address, prefectures, cites, changeAddress);
  }

  /// 未選択項目を追加
  Map<int, String> addUnselectedItems(Map<int, String> addresses) {
    final data = {-1: '未選択'};
    data.addAll(addresses);
    return data;
  }
}
