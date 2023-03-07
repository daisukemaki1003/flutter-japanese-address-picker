// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/src/address_model.dart';
import 'package:japanese_prefecture_picker/src/address_picker_theme.dart';
import 'package:japanese_prefecture_picker/src/widgets/japanese_address_picker_view_item.dart';

class JapaneseAddressPickerView extends StatelessWidget {
  JapaneseAddressPickerView({
    Key? key,
    required this.theme,
    required this.address,
    required this.prefectures,
    required this.cites,
    required this.onChange,
  }) : super(key: key);

  final JapanesePrefecturePickerTheme theme;

  /// 選択中のアドレスデータ
  final Address? address;

  /// 表示する都道府県データ
  final List<AddressItem> prefectures;

  /// 表示する市町村データ
  final List<AddressItem> cites;

  /// 選択中のアドレスデータが更新された際に呼び出す
  final Function(Address?) onChange;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(children: [
        JapaneseAddressPickerViewItem(
          addresses: prefectures,
          onChange: (index) => onChange(
            address?.copyWith(prefecture: prefectures[index]),
          ),
        ),
        JapaneseAddressPickerViewItem(
          addresses: cites,
          onChange: (index) => onChange(
            address?.copyWith(city: cites[index]),
          ),
        ),
      ]),
    );
  }
}
