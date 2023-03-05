import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/src/utils/assets_loader.dart';

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

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BottomSheet(
          backgroundColor: Colors.transparent,
          enableDrag: false,
          onClosing: () {},
          builder: (context) => this,
        );
      },
    );
  }

  @override
  State createState() => _JapanesePrefecturePickerState();
}

class _JapanesePrefecturePickerState extends State<JapanesePrefecturePicker> {
  final List<String> items = [];

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
          Expanded(
            child: CupertinoTheme(
              data: CupertinoThemeData(textTheme: CupertinoTextThemeData()),
              child: CupertinoPicker(
                itemExtent: widget.itemExtent,
                scrollController: FixedExtentScrollController(),
                onSelectedItemChanged: (i) => widget.onChange?.call(items[i]),
                children: items.map((e) => Text(e)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
