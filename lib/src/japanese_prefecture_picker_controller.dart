import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:japanese_prefecture_picker/src/data/address.dart';
import 'package:japanese_prefecture_picker/src/data/address_item.dart';

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
    List<AddressItem> prefectures,
    List<AddressItem> cites,
    void Function(Address) onChange,
  ) builder;

  @override
  State<StatefulWidget> createState() =>
      _JapanesePrefecturePickerControllerState();
}

class _JapanesePrefecturePickerControllerState
    extends State<JapanesePrefecturePickerController> {
  /// 全アドレスデータ
  List addresses = [];

  /// 選択されたアドレス
  Address selected = Address();

  /// 表示する都道府県データ
  List<AddressItem> prefectures = [];

  /// 表示する市町村データ
  List<AddressItem> cites = [];

  changeAddress(Address newAddress) {
    /// 選択された都道府県IDに応じて表示する市町村データを生成します。
    if (selected.prefectureId != newAddress.prefectureId) {
      cites = addUnselectedItems(cityAddressItems(newAddress.prefectureId));
    }

    /// アドレスデータを更新
    setState(() => selected = newAddress);
  }

  Future<List> loadAddresses() async {
    return await json.decode(await rootBundle.loadString(
      'packages/japanese_prefecture_picker/assets/address_seeds.json',
    ));
  }

  List<AddressItem> prefectureAddressItems() {
    return addresses.map((e) {
      return AddressItem(e['id'], e['name']);
    }).toList();
  }

  List<AddressItem> cityAddressItems(int prefectureId) {
    for (var address in addresses) {
      if (address['id'] == prefectureId) {
        return (address['cites'] as List).map((e) {
          return AddressItem(e['id'], e['name']);
        }).toList();
      }
    }
    return [];
  }

  @override
  void initState() {
    /// アドレスデータ読み込み
    Future(() async {
      addresses = await loadAddresses();
      prefectures = prefectureAddressItems();
      cites = addUnselectedItems(cityAddressItems(selected.prefectureId));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(selected, prefectures, cites, changeAddress);
  }

  /// 未選択項目を追加
  List<AddressItem> addUnselectedItems(List<AddressItem> addresses) {
    final unselectedItems = AddressItem(-1, '未選択');
    return [unselectedItems, ...addresses];
  }
}
