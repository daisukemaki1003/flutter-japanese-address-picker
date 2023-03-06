import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/src/data/address.dart';

class JapanesePrefecturePickerViewItem extends StatelessWidget {
  const JapanesePrefecturePickerViewItem._({
    required this.itemCount,
    required this.builder,
    required this.onChange,
  });

  /// 表示するアイテム数
  /// [itemCount]の回数分[builder]関数を実行しWidgetを生成します。
  final int itemCount;

  /// 表示するアドレスデータを生成
  /// 引数には実行回数が入り、この関数は[itemCount]の数だけ実行されます。
  final Widget Function(int index) builder;

  /// アドレスデータが変更された際に呼び出される関数
  /// 引数には選択されたアドレスのKeyのIndexが返されます
  final Function(int index) onChange;

  factory JapanesePrefecturePickerViewItem({
    required List<AddressItem> addresses,
    required Function(int) onChange,
  }) {
    return JapanesePrefecturePickerViewItem._(
      onChange: onChange,
      itemCount: addresses.length,
      builder: (index) => Container(
        alignment: Alignment.center,
        child: Text(
          addresses[index].name,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener(
        /// TODO スクロールが終了した時に市町村データを更新する
        child: CupertinoPicker(
          itemExtent: 35.0,
          useMagnifier: true,
          backgroundColor: Colors.white,
          onSelectedItemChanged: onChange,
          children: List.generate(itemCount, builder).toList(),
        ),
      ),
    );
  }
}
