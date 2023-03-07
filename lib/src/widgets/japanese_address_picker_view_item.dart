import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_japanese_address_picker/src/address_model.dart';

class JapaneseAddressPickerViewItem extends StatelessWidget {
  const JapaneseAddressPickerViewItem({
    required this.addresses,
    required this.onChange,
    required this.scrollController,
  });

  /// 表示するアドレスデータリスト
  final List<AddressItem> addresses;

  /// アドレスデータが変更された際に呼び出される関数
  /// 引数には選択されたアドレスのKeyのIndexが返されます
  final Function(AddressItem) onChange;

  final FixedExtentScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener(
        // onNotification: (ScrollNotification notification) {
        //   if (notification.depth == 0 &&
        //       notification is ScrollEndNotification &&
        //       notification.metrics is FixedExtentMetrics) {
        //     final FixedExtentMetrics metrics =
        //         notification.metrics as FixedExtentMetrics;
        //     final int currentItemIndex = metrics.itemIndex;
        //     selectedChangedWhenScrollEnd(currentItemIndex);
        //   }
        //   return false;
        // },

        /// TODO スクロールが終了した時に市町村データを更新する
        child: CupertinoPicker(
          key: key,
          itemExtent: 35.0,
          backgroundColor: Colors.white,
          scrollController: addresses.isNotEmpty ? scrollController : null,
          onSelectedItemChanged: (index) => onChange(addresses[index]),
          children: List.generate(addresses.length, (index) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                addresses[index].name,
                textAlign: TextAlign.start,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
