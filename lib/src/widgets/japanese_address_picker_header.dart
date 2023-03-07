import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/src/address_picker_theme.dart';

class JapaneseAddressPickerHeader extends StatelessWidget {
  JapaneseAddressPickerHeader({
    Key? key,
    required this.theme,
    required this.onCansel,
    required this.onSave,
  }) : super(key: key);

  final JapanesePrefecturePickerTheme theme;

  /// 当道府県データの選択をキャンセルした時の処理
  final VoidCallback? onCansel;

  /// 当道府県データを保存時の処理
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: theme.headerHeight,
      color: theme.headerColor,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          headerItem(
            Alignment.centerLeft,
            TextButton(
              onPressed: onCansel,
              child: Text(theme.headerCansel, style: theme.headerCanselStyle),
            ),
          ),
          headerItem(
            Alignment.center,
            Text(theme.headerTitle, style: theme.headerTitleStyle),
          ),
          headerItem(
            Alignment.centerRight,
            TextButton(
              onPressed: onSave,
              child: Text(theme.headerSave, style: theme.headerSaveStyle),
            ),
          ),
        ],
      ),
    );
  }

  headerItem(AlignmentGeometry? alignment, Widget? widget) {
    return Expanded(child: Container(alignment: alignment, child: widget));
  }
}
