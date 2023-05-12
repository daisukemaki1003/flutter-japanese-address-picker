import 'package:flutter_japanese_address_picker/flutter_japanese_address_picker.dart';
import 'package:flutter_japanese_address_picker/src/address_util.dart';

/// 未選択
const _unselectedValue = '未選択';

abstract class _BasePickerModel {
  /// 選択中の都道府県データのIndexを取得
  int currentPrefectureIndex();

  /// 選択中の市町村データのIndexを取得
  int currentCityIndex();

  /// 都道府県を選択する
  void setPrefectureIndex(int index);

  /// 市町村を選択する
  void setCityIndex(int index);

  /// 都道府県名をIndexから取得する
  String prefectureAtIndex(int index);

  /// 市町村名をIndexから取得する
  String cityAtIndex(int index);

  /// 選択中の都道府県データを取得する
  AddressModel? finalAddress();
}

class _CommonPickerModel extends _BasePickerModel {
  late List<AddressesModel> addresses;
  List<String> prefectures = [];
  List<String> cites = [];
  int _currentPrefectureIndex = 0;
  int _currentCityIndex = 0;
  // late AddressModel _currentAddress;
  final bool isAllowUnselectedPrefecture;
  final bool isAllowUnselectedCity;

  _CommonPickerModel({
    bool? isAllowUnselectedPrefecture,
    bool? isAllowUnselectedCity,
  })  : isAllowUnselectedPrefecture = isAllowUnselectedPrefecture ?? false,
        isAllowUnselectedCity = isAllowUnselectedCity ?? false;

  @override
  String cityAtIndex(int index) {
    return cites[index];
  }

  @override
  String prefectureAtIndex(int index) {
    return prefectures[index];
  }

  @override
  int currentCityIndex() {
    return _currentCityIndex;
  }

  @override
  int currentPrefectureIndex() {
    return _currentPrefectureIndex;
  }

  @override
  void setCityIndex(int index) {
    index.isFinite ? _currentCityIndex = index : _currentCityIndex = 0;
  }

  @override
  void setPrefectureIndex(int index) {
    index.isFinite
        ? _currentPrefectureIndex = index
        : _currentPrefectureIndex = 0;
    setCityIndex(0);
  }

  @override
  AddressModel? finalAddress() {
    return AddressModel(
      prefecture: prefectureAtIndex(currentPrefectureIndex()),
      city: cityAtIndex(currentCityIndex()),
    );
  }
}

class AddressPickerModel extends _CommonPickerModel {
  AddressPickerModel({
    bool? isAllowUnselectedPrefecture,
    bool? isAllowUnselectedCity,
    AddressModel? currentAddress,
  }) : super(
          isAllowUnselectedPrefecture: isAllowUnselectedPrefecture,
          isAllowUnselectedCity: isAllowUnselectedCity,
        ) {
    /// 都道府県データを取得
    loadAddresses().then((addresses) {
      this.addresses = addresses;

      /// 都道府県名を取得
      fillPrefectures();
      if (currentAddress != null) {
        setPrefectureIndex(prefectures.indexOf(currentAddress.prefecture));
      } else {
        setPrefectureIndex(0);
      }

      /// 市町村データを取得
      if (currentAddress != null && currentAddress.hasCity) {
        setCityIndex(cites.indexOf(currentAddress.city!));
      }
    });
  }

  @override
  void setPrefectureIndex(int index) {
    super.setPrefectureIndex(index);
    fillCites();
  }

  void fillPrefectures() {
    if (isAllowUnselectedPrefecture) prefectures = [_unselectedValue];
    prefectures.addAll(addresses.map((address) => address.prefecture));
  }

  void fillCites() {
    if (isAllowUnselectedCity) cites = [_unselectedValue];
    for (var address in addresses) {
      if (address.prefecture == prefectures[currentPrefectureIndex()]) {
        cites.addAll(address.cites);
      }
    }
  }

  @override
  AddressModel? finalAddress() {
    final address = super.finalAddress();
    if (address == null) return null;
    if (address.prefecture == _unselectedValue) return null;
    if (address.city == _unselectedValue) return address.copyWith(city: null);
    return address;
  }
}
