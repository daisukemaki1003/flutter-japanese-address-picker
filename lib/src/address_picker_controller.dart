import 'package:flutter/material.dart';
import 'package:flutter_japanese_address_picker/flutter_japanese_address_picker.dart';
import 'package:flutter_japanese_address_picker/src/address_util.dart';

class AddressPickerController {
  /// 選択されたアドレス
  Address? selected;

  /// 全アドレスデータ
  final List addresses;

  /// 表示する都道府県データ
  List<AddressItem> prefectures = [];

  /// 表示する市町村データ
  List<AddressItem> cites = [];

  FixedExtentScrollController? prefScrollController;
  FixedExtentScrollController? cityScrollController;

  AddressPickerController(this.addresses) {
    setPrefectures(addresses);
    setCites(addresses, 0);
    selected = Address(prefecture: prefectures[0], city: cites[0]);
  }

  /// prefScrollController
  setPrefScrollController(controller) {
    prefScrollController = controller;
  }

  /// prefScrollController
  setCityScrollController(controller) {
    cityScrollController = controller;
  }

  setAddress(Address? address) {
    if (address == null) return;

    // / 選択された都道府県IDに応じて表示する市町村データを生成します。
    if (selected?.prefecture.id != address.prefecture.id) {
      setCites(addresses, address.prefecture.id);
      _addUnselectedItems();
    }

    /// アドレスデータを更新
    selected = address;
  }

  /// 市町村を選択する
  void selectedCity(AddressItem address) {
    selected = selected?.copyWith(city: address);
  }

  /// 都道府県を選択する
  void selectedPrefecture(AddressItem address) {
    selected = selected?.copyWith(prefecture: address);
  }

  void setPrefectures(List addresses) {
    prefectures = addresses.map((e) {
      return AddressItem(e['id'], e['name']);
    }).toList();
  }

  void setCites(List addresses, int prefectureId) {
    for (var address in addresses) {
      if (address['id'] == prefectureId) {
        cites = (address['cites'] as List).map((e) {
          return AddressItem(e['id'], e['name']);
        }).toList();
      }
    }
  }

  /// 未選択項目を追加
  void _addUnselectedItems() {
    final unselectedItems = AddressItem(-1, '未選択');
    cites = [unselectedItems, ...cites];
  }
}
