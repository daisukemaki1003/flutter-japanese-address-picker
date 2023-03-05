import 'package:flutter/material.dart';

class BottomSheetHeader extends StatelessWidget {
  BottomSheetHeader({
    Key? key,
    this.height = 40.0,
    Color? backgroundColor,
    EdgeInsets? padding,
    this.leading,
    this.trailing,
  }) : super(key: key) {
    this.padding = padding ?? EdgeInsets.symmetric(horizontal: 10);
    this.backgroundColor = backgroundColor ?? Color(0xFFEEEEEE);
  }

  /// ヘッダーの高さ
  /// デフォルトの高さは[40.0]
  final double height;

  /// ヘッダーの背景色
  /// デフォルトの背景色は[Color(0xFFEEEEEE)]
  /// by default it's [Color(0xFFEEEEEE)]
  late final Color backgroundColor;

  /// ヘッダーのPadding
  /// デフォルトのPaddingは[EdgeInsets.symmetric(horizontal: 10)]
  /// ヘッダー内の各WidgetのPaddingについては、Containerに格納し各自Paddingを設定してください。
  late final EdgeInsets padding;

  /// ヘッダーの左端に表示するWidget
  final Widget? leading;

  /// ヘッダーの右端に表示するWidget
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: backgroundColor,
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: leading ?? Container()),
          Text('タイトル', style: TextStyle(fontSize: 16)),
          Expanded(child: trailing ?? Container())
        ],
      ),
    );
  }
}
