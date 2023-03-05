import 'package:flutter/material.dart';

class JapanesePrefecturePicker extends StatefulWidget {
  const JapanesePrefecturePicker({
    Key? key,
    this.header,
  }) : super(key: key);

  /// ピッカーのヘッダー
  final Widget? header;

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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          widget.header ?? Container(),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }
}
