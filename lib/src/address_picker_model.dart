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
  String? prefectureNameAtIndex(int index);

  /// 市町村名をIndexから取得する
  String? cityNameAtIndex(int index);
}

class _CommonPickerModel extends _BasePickerModel {
  List<AddressesModel> addresses = [];
  List<String> prefectures = [];
  List<String> cites = [];
  AddressModel? currentAddress;
  int _currentPrefectureIndex = 0;
  int _currentCityIndex = 0;
  final bool isAllowUnselectedPrefecture;
  final bool isAllowUnselectedCity;

  _CommonPickerModel({
    bool? isAllowUnselectedPrefecture,
    bool? isAllowUnselectedCity,
  })  : isAllowUnselectedPrefecture = isAllowUnselectedPrefecture ?? false,
        isAllowUnselectedCity = isAllowUnselectedCity ?? false;

  @override
  String? cityNameAtIndex(int index) {
    return cites[index];
  }

  @override
  String? prefectureNameAtIndex(int index) {
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
    _currentCityIndex = index;
    if (index.isNegative) _currentCityIndex = 0;
  }

  @override
  void setPrefectureIndex(int index) {
    setCityIndex(0);
    _currentPrefectureIndex = index;
    if (index.isNegative) _currentPrefectureIndex = 0;
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
    this.currentAddress = currentAddress;

    /// 都道府県データを取得
    loadAddresses().then((addresses) {
      this.addresses = addresses;

      /// 都道府県名を取得
      fillPrefectures();
      if (currentAddress?.hasPrefecture == true) {
        setPrefectureIndex(prefectures.indexOf(currentAddress!.prefecture!));
      }

      /// 市町村データを取得
      fillCites();
      if (currentAddress?.hasCity == true) {
        setCityIndex(cites.indexOf(currentAddress!.city!));
      }
    });
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
}

// class AddressPickerModel {
//   /// 選択されたアドレス
//   Address? selected;

//   /// 全アドレスデータ
//   final List addresses;

//   /// 表示する都道府県データ
//   List<AddressItem> prefectures = [];

//   /// 表示する市町村データ
//   List<AddressItem> cites = [];

//   AddressPickerModel(this.addresses, AddressValue initialValue) {
//     setPrefectures();
//     setCites(initialValue.prefectureId ?? 0);
//     initialization(initialValue);
//   }

//   /// 選択データの初期化処理
//   initialization(AddressValue value) {
//     int initialPrefectureIndex = 0;
//     int initialCityIndex = 0;

//     setTheValue() => selected = Address(
//           prefecture: prefectures[initialPrefectureIndex],
//           city: cites[initialCityIndex],
//         );

//     if (value.prefectureId != null) {
//       initialPrefectureIndex = getPrefectureIndexById(value.prefectureId!);
//     } else if (value.prefectureName != null) {
//       initialPrefectureIndex = getPrefectureIndexByName(value.prefectureName!);
//     } else {
//       setTheValue();
//       return;
//     }
//     if (value.cityId != null) {
//       initialCityIndex = getCityIndexById(value.cityId!);
//     } else if (value.cityName != null) {
//       initialCityIndex = getCityIndexByName(value.cityName!);
//     }
//     setTheValue();
//   }

//   /// 選択中の都道府県データのIndexを取得
//   int getSelectedPrefectureIndex() {
//     return getPrefectureIndexById(selected!.prefecture.id);
//   }

//   /// 選択中の市町村データのIndexを取得
//   int getSelectedCityIndex() {
//     return getCityIndexById(selected!.city.id);
//   }

//   /// [id]都道府県IDを検索し一致するデータのIndexを取得する
//   int getPrefectureIndexById(AddressID id) {
//     return getIndexById(prefectures, id);
//   }

//   /// [name]都道府県名を検索し一致するデータのIndexを取得する
//   int getPrefectureIndexByName(String name) {
//     return getIndexByName(prefectures, name);
//   }

//   /// [id]市町村IDを検索し一致するデータのIndexを取得する
//   int getCityIndexById(AddressID id) {
//     return getIndexById(cites, id);
//   }

//   /// [name]市町村名を検索し一致するデータのIndexを取得する
//   int getCityIndexByName(String name) {
//     return getIndexByName(cites, name);
//   }

//   /// [addresses]内から[id]を保持するデータを検索します。
//   /// 検索対象が存在した場合は[address]内のIndexを返します。
//   /// 存在しなかったら'0'を返します。
//   int getIndexById(List<AddressItem> addresses, AddressID id) {
//     final index = addresses.indexWhere((element) => element.id == id);
//     if (index < 0) return 0;
//     return index;
//   }

//   /// [addresses]内から[name]が一致するデータを検索します。
//   /// 検索対象が存在した場合は[address]内のIndexを返します。
//   /// 存在しなかったら'0'を返します。
//   int getIndexByName(List<AddressItem> addresses, String name) {
//     final index = addresses.indexWhere((address) => address.name == name);
//     if (index < 0) return 0;
//     return index;
//   }

//   /// 都道府県を選択する
//   void selectedPrefecture(AddressItem address) {
//     selected = selected?.copyWith(
//       prefecture: address,
//       city: _unselectedItem(),
//     );
//   }

//   /// 市町村を選択する
//   void selectedCity(AddressItem address) {
//     selected = selected?.copyWith(city: address);
//   }

//   /// 都道府県データリストを保存
//   void setPrefectures() {
//     prefectures = addresses.map((e) {
//       return AddressItem(e['id'], e['name']);
//     }).toList();
//   }

//   /// 市町村データリストを保存
//   void setCites(int prefectureId) {
//     final datas = [_unselectedItem()];
//     for (var address in addresses) {
//       if (address['id'] == prefectureId) {
//         datas.addAll((address['cites'] as List).map((e) {
//           return AddressItem(e['id'], e['name']);
//         }).toList());
//       }
//     }
//     cites = datas;
//   }

//   /// 未選択項目
//   AddressItem _unselectedItem() {
//     return AddressItem(-1, '未選択');
//   }
// }
