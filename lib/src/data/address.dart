class AddressItem {
  final int id;
  final String name;

  AddressItem(this.id, this.name);
}

class Address {
  /// 都道府県
  final AddressItem prefecture;

  /// 市町村
  final AddressItem city;

  Address({
    required this.prefecture,
    required this.city,
  });

  Address copyWith({AddressItem? city, AddressItem? prefecture}) {
    return Address(
      city: city ?? this.city,
      prefecture: prefecture ?? this.prefecture,
    );
  }

  // /// 都道府県名
  // String get prefecture {
  //   try {
  //     return getPrefectures(this)?['prefecture'] as String;
  //   } catch (e) {
  //     return '未選択';
  //   }
  // }

  // /// 市町村名
  // String get city {
  //   try {
  //     return getCites(this)?[cityId] as String;
  //   } catch (e) {
  //     return '未選択';
  //   }
  // }
}
