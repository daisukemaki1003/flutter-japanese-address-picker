import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JapanesePrefecturePickerView extends StatefulWidget {
  const JapanesePrefecturePickerView({Key? key}) : super(key: key);

  @override
  State createState() => _JapanesePrefecturePickerViewState();
}

class _JapanesePrefecturePickerViewState
    extends State<JapanesePrefecturePickerView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomSingleChildLayout(
        delegate: _JapanesePrefecturePickerViewLayout(),
        child: Row(children: [_item(), _item()]),
      ),
    );
  }

  Widget _item() {
    return Expanded(
      child: NotificationListener(
        child: CupertinoPicker.builder(
          backgroundColor: Colors.white,
          itemExtent: 35.0,
          onSelectedItemChanged: (int index) {},
          useMagnifier: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              child: Text('データ', textAlign: TextAlign.start),
            );
          },
        ),
      ),
    );
  }
}

class _JapanesePrefecturePickerViewLayout extends SingleChildLayoutDelegate {
  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) {
    return true;
  }
}
