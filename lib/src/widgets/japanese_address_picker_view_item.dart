import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_japanese_address_picker/src/address_model.dart';

class JapaneseAddressPickerViewItem extends StatelessWidget {
  const JapaneseAddressPickerViewItem({
    this.valueKey,
    required this.addresses,
    required this.scrollController,
    required this.onSelectedItemChanged,
    required this.onSelectedItemChangedWhenScrollEnd,
  });

  final ValueKey? valueKey;

  /// 表示するアドレスデータリスト
  final List<AddressItem> addresses;

  final FixedExtentScrollController? scrollController;

  /// アドレスデータが変更された際に呼び出される関数
  final ValueChanged<AddressItem> onSelectedItemChanged;
  final ValueChanged<AddressItem> onSelectedItemChangedWhenScrollEnd;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification.depth == 0 &&
              notification is ScrollEndNotification &&
              notification.metrics is FixedExtentMetrics) {
            final FixedExtentMetrics metrics =
                notification.metrics as FixedExtentMetrics;
            final int currentItemIndex = metrics.itemIndex;
            onSelectedItemChangedWhenScrollEnd(addresses[currentItemIndex]);
          }
          return false;
        },
        child: CupertinoPicker.builder(
          key: valueKey,
          itemExtent: 35.0,
          useMagnifier: true,
          backgroundColor: Colors.white,
          scrollController: scrollController,
          onSelectedItemChanged: (index) {
            onSelectedItemChanged(addresses[index]);
          },
          childCount: addresses.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                addresses[index].name,
                textAlign: TextAlign.start,
              ),
            );
          },
        ),
      ),
    );
  }
}
