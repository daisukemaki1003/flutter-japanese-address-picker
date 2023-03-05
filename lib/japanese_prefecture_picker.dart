import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JapanesePrefecturePicker extends StatefulWidget {
  const JapanesePrefecturePicker({
    Key? key,
    this.title,
  }) : super(key: key);

  /// ピッカーのタイトル
  /// 未入力の場合はタイトルが表示されません。
  final String? title;

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: false,
      constraints: const BoxConstraints(),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BottomSheet(
          backgroundColor: Colors.transparent,
          enableDrag: false,
          onClosing: () {},
          builder: (context) {
            return this;
          },
        );
      },
    );
  }

  @override
  State createState() => _JapanesePrefecturePickerState();
}

class _JapanesePrefecturePickerState extends State<JapanesePrefecturePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Expanded(
        child: CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(),
          ),
          child: CupertinoPicker(
            itemExtent: 300,
            scrollController: FixedExtentScrollController(),
            onSelectedItemChanged: (i) {},
            children: [
              Text('data'),
              Text('data'),
            ],
          ),
        ),
      ),
    );
  }
}
