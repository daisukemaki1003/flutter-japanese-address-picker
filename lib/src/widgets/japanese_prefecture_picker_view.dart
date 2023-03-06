// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/src/data/address.dart';
import 'package:japanese_prefecture_picker/src/data/fake_address.dart';
import 'package:japanese_prefecture_picker/src/japanese_prefecture_picker_theme.dart';
import 'package:japanese_prefecture_picker/src/widgets/japanese_prefecture_picker_view_item.dart';

class JapanesePrefecturePickerView extends StatefulWidget {
  JapanesePrefecturePickerView({
    Key? key,
    required this.theme,
    required this.address,
    required this.onChange,
  }) : super(key: key);

  final JapanesePrefecturePickerTheme theme;
  final Address address;
  final Function(Address) onChange;

  @override
  State<StatefulWidget> createState() => _JapanesePrefecturePickerViewState();
}

class _JapanesePrefecturePickerViewState
    extends State<JapanesePrefecturePickerView> {
  /// 表示する都道府県データ
  Map<int, String> prefectures = {};

  /// 表示する市町村データ
  Map<int, String> cites = {};

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
    cites = json[widget.address.prefectureId]!['cites'] as Map<int, String>;

    return Expanded(
      child: Row(children: [
        JapanesePrefecturePickerViewItem(
          addresses: prefectures,
          onChange: (index) {
            widget.onChange(widget.address.copyWith(
              prefectureId: prefectures.keys.elementAt(index),
            ));
          },
        ),
        JapanesePrefecturePickerViewItem(
          addresses: cites,
          onChange: (index) {
            widget.onChange(widget.address.copyWith(
              cityId: cites.keys.elementAt(index),
            ));
          },
        ),
      ]),
    );
  }
}
