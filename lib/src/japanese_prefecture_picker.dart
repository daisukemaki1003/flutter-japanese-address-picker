import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/src/data/address.dart';
import 'package:japanese_prefecture_picker/src/widgets/japanese_prefecture_picker_view.dart';

class JapanesePrefecturePicker extends StatefulWidget {
  const JapanesePrefecturePicker({
    Key? key,
    this.header,
    this.itemExtent = 35.0,
    this.onChange,
  }) : super(key: key);

  /// ピッカーのヘッダー
  final Widget? header;

  /// リストピッカーのアイテム範囲
  /// デフォルト値は[35.0]
  final double itemExtent;

  /// ピッカー項目間を移動するときに呼び出されるNullable関数
  /// 選択された都道府県市データを返します
  final Function(dynamic)? onChange;

  void show(BuildContext context) => showModalBottomSheet(
        context: context,
        enableDrag: false,
        isScrollControlled: false,
        backgroundColor: Colors.transparent,
        builder: (context) => BottomSheet(
          backgroundColor: Colors.transparent,
          enableDrag: false,
          onClosing: () {},
          builder: (context) => this,
        ),
      );

  @override
  State createState() => _JapanesePrefecturePickerState();
}

class _JapanesePrefecturePickerState extends State<JapanesePrefecturePicker> {
  final List<Address> addresses = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          widget.header ?? Container(),
          JapanesePrefecturePickerView(),
        ],
      ),
    );
  }
}
