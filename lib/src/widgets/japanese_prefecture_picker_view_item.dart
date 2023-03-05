import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JapanesePrefecturePickerViewItem extends StatelessWidget {
  const JapanesePrefecturePickerViewItem._({
    required this.itemCount,
    required this.builder,
    required this.onChange,
  });

  final int itemCount;
  final Widget Function(int) builder;
  final Function(int) onChange;

  factory JapanesePrefecturePickerViewItem(
    Map<int, String> addresses, {
    required Function(int) onChange,
  }) {
    return JapanesePrefecturePickerViewItem._(
      onChange: onChange,
      itemCount: addresses.length,
      builder: (index) => Container(
        alignment: Alignment.center,
        child: Text(
          addresses[addresses.keys.elementAt(index)]!,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener(
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
