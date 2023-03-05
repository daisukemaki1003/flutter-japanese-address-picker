import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/src/data/fake_address.dart';
import 'package:japanese_prefecture_picker/src/widgets/japanese_prefecture_picker_view_item.dart';

class JapanesePrefecturePickerView extends StatefulWidget {
  const JapanesePrefecturePickerView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _JapanesePrefecturePickerViewState();
}

class _JapanesePrefecturePickerViewState
    extends State<JapanesePrefecturePickerView> {
  /// 選択された都道府県のID
  int prefectureId = 0;

  /// 選択された市町村のID
  int cityId = 0;

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
    cites = json[prefectureId]!['cites'] as Map<int, String>;

    return Expanded(
      child: Row(children: [
        _pickerItem(prefectures, (id) => prefectureId = id),
        _pickerItem(cites, (id) => cityId = id),
      ]),
    );
  }

  _pickerItem(Map<int, String> addresses, Function(int id) onChange) {
    return JapanesePrefecturePickerViewItem(
      addresses: addresses,
      onChange: (index) {
        setState(() => onChange(addresses.keys.elementAt(index)));
      },
    );
  }
}
