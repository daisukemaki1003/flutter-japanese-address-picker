import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  final List<String> addresses;

  final FixedExtentScrollController? scrollController;

  /// アドレスデータが変更された際に呼び出される関数
  final ValueChanged<int> onSelectedItemChanged;
  final ValueChanged<int> onSelectedItemChangedWhenScrollEnd;

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
            onSelectedItemChangedWhenScrollEnd(currentItemIndex);
          }
          return false;
        },
        child: CupertinoPicker.builder(
          key: valueKey,
          itemExtent: 35.0,
          useMagnifier: true,
          backgroundColor: Colors.white,
          scrollController: scrollController,
          onSelectedItemChanged: onSelectedItemChanged,
          childCount: addresses.length,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              child: Text(
                addresses[index],
                textAlign: TextAlign.start,
              ),
            );
          },
        ),
      ),
    );
  }
}
