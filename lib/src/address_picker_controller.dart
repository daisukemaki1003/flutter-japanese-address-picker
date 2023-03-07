import 'package:flutter_japanese_address_picker/flutter_japanese_address_picker.dart';

class AddressPickerController {
  /// 選択されたアドレス
  Address? selected;

  /// 全アドレスデータ
  final List addresses;

  /// 表示する都道府県データ
  List<AddressItem> prefectures = [];

  /// 表示する市町村データ
  List<AddressItem> cites = [];

  AddressPickerController(this.addresses) {
    setPrefectures();
    setCites(0);
    selected = Address(prefecture: prefectures[0], city: cites[0]);
  }

  /// 選択中都道府県データのIndexを取得
  int getSelectedPrefectureIndex() {
    return prefectures.indexOf(selected!.prefecture);
  }

  /// 選択中市町村データのIndexを取得
  int getSelectedCityIndex() {
    final index = cites.indexWhere(
      (address) => address.id == selected?.city.id,
    );
    if (index < 0) return 0;
    return index;
  }

  /// 都道府県を選択する
  void selectedPrefecture(AddressItem address) {
    selected = selected?.copyWith(
      prefecture: address,
      city: _unselectedItem(),
    );
  }

  /// 市町村を選択する
  void selectedCity(AddressItem address) {
    selected = selected?.copyWith(city: address);
  }

  /// 都道府県データリストを保存
  void setPrefectures() {
    prefectures = addresses.map((e) {
      return AddressItem(e['id'], e['name']);
    }).toList();
  }

  /// 市町村データリストを保存
  void setCites(int prefectureId) {
    final datas = [_unselectedItem()];
    for (var address in addresses) {
      if (address['id'] == prefectureId) {
        datas.addAll((address['cites'] as List).map((e) {
          return AddressItem(e['id'], e['name']);
        }).toList());
      }
    }
    cites = datas;
  }

  /// 未選択項目
  AddressItem _unselectedItem() {
    return AddressItem(-1, '未選択');
  }
}
