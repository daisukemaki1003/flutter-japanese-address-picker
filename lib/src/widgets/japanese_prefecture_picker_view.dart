import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/src/data/fake_address.dart';
import 'package:japanese_prefecture_picker/src/widgets/japanese_prefecture_picker_view_item.dart';

class JapanesePrefecturePickerView extends StatefulWidget {
  const JapanesePrefecturePickerView({Key? key}) : super(key: key);

  @override
  State createState() => _JapanesePrefecturePickerViewState();
}

class _JapanesePrefecturePickerViewState
    extends State<JapanesePrefecturePickerView> {
  int prefectureId = 0;
  int cityId = 0;
  Map<int, String> prefectures = {};
  Map<int, String> cites = {};

  @override
  void initState() {
    json.forEach((key, value) {
      prefectures[key] = value['prefecture'] as String;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cites = json[prefectureId]!['cites'] as Map<int, String>;

    return Expanded(
      child: CustomSingleChildLayout(
        delegate: _JapanesePrefecturePickerViewLayout(),
        child: Row(children: [
          _pickerItem(prefectures, (id) => setState(() => prefectureId = id)),
          _pickerItem(cites, (id) => setState(() => cityId = id)),
        ]),
      ),
    );
  }

  JapanesePrefecturePickerViewItem _pickerItem(
    Map<int, String> addresses,
    Function(int addressId) onChange,
  ) {
    return JapanesePrefecturePickerViewItem(
      addresses,
      onChange: (index) => onChange(addresses.keys.elementAt(index)),
    );
  }
}

class _JapanesePrefecturePickerViewLayout extends SingleChildLayoutDelegate {
  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) {
    return true;
  }
}
