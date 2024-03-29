import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

// typedef AddressID = int;

/// [AddressItem]で定義された[prefecture]都道府県と[city]市町村で構成される
/// このデータモデルはJapaneseAddressPickerの返り値として利用されます。
// class Address {
//   /// 都道府県
//   final AddressItem prefecture;

//   /// 市町村
//   final AddressItem city;

//   Address({
//     required this.prefecture,
//     required this.city,
//   });

//   Address copyWith({AddressItem? city, AddressItem? prefecture}) {
//     return Address(
//       city: city ?? this.city,
//       prefecture: prefecture ?? this.prefecture,
//     );
//   }
// }

/// [Address]の構成要素
/// [id]アドレスIDと[name]地名二のつのパラメータで構成される
/// 都道府県データ・市町村データ共に利用します
// class AddressItem {
//   /// アドレスID
//   final AddressID id;

//   /// 地名
//   final String name;

//   AddressItem(this.id, this.name);
// }

// /// ユーザーがピッカーに初期値を与える際に利用します。
// class AddressValue {
//   final AddressID? cityId;
//   final AddressID? prefectureId;

//   final String? cityName;
//   final String? prefectureName;

//   AddressValue({
//     this.cityId,
//     this.prefectureId,
//     this.cityName,
//     this.prefectureName,
//   });
// }

@freezed
class AddressModel with _$AddressModel {
  const AddressModel._();
  const factory AddressModel({
    required String prefecture,
    @Default(null) String? city,
  }) = _AddressModel;

  /// [city]が存在するかどうか
  bool get hasCity => city != null;
}

@freezed
class AddressesModel with _$AddressesModel {
  const factory AddressesModel({
    required String prefecture,
    required List<String> cites,
  }) = _AddressesModel;

  factory AddressesModel.fromJson(Map<String, dynamic> json) =>
      _$AddressesModelFromJson(json);
}
