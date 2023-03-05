import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/japanese_prefecture_picker.dart';
import 'package:japanese_prefecture_picker/src/data/address.dart';
import 'package:japanese_prefecture_picker/src/japanese_prefecture_picker_theme.dart';
import 'package:japanese_prefecture_picker/src/widgets/japanese_prefecture_picker_view.dart';

typedef AddressChangedCallback = Function(Address address);

class JapanesePrefecturePicker {
  /// [showHeader]ボトムソートにヘッダーを表示するか
  /// falseの場合はヘッダーを表示しない
  static showBottomSheet(
    BuildContext context, {
    bool showHeader = false,
    JapanesePrefecturePickerHeader? header,
    VoidCallback? onCancel,
    AddressChangedCallback? onChanged,
    JapanesePrefecturePickerTheme? theme,
  }) async {
    return await Navigator.push(
      context,
      _JapanesePrefecturePickerRoute(
        showHeader: showHeader,
        header: header ?? JapanesePrefecturePickerHeader(),
        onChanged: onChanged,
        onCancel: onCancel,
        barrierLabel: MaterialLocalizations.of(
          context,
        ).modalBarrierDismissLabel,
        theme: theme ?? JapanesePrefecturePickerTheme(),
      ),
    );
  }
}

// ignore: unused_element
class _JapanesePrefecturePickerRoute<T> extends PopupRoute<T> {
  _JapanesePrefecturePickerRoute({
    required this.showHeader,
    required this.header,
    this.itemExtent = 35.0,
    this.onChanged,
    this.onCancel,
    this.barrierLabel,
    required this.theme,
    RouteSettings? settings,
  }) : super(settings: settings);

  /// ヘッダーを表示するかどうか
  final bool showHeader;

  /// ピッカーのヘッダー
  final JapanesePrefecturePickerHeader header;

  /// リストピッカーのアイテム範囲
  /// デフォルト値は[35.0]
  final double itemExtent;

  /// ピッカー項目間を移動するときに呼び出されるNullable関数
  /// 選択された都道府県市データを返します
  final AddressChangedCallback? onChanged;

  /// ピッカーのキャンセルボタンを押した際のNullable関数
  final VoidCallback? onCancel;

  /// [JapanesePrefecturePickerTheme]のスタイルを制御
  final JapanesePrefecturePickerTheme theme;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController? _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = BottomSheet.createAnimationController(
      navigator!.overlay!,
    );
    return _animationController!;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return InheritedTheme.captureAll(
      context,
      MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: _JapanesePrefecturePickerComponent(
          onChanged: onChanged,
          route: this,
        ),
      ),
    );
  }
}

class _JapanesePrefecturePickerComponent extends StatefulWidget {
  const _JapanesePrefecturePickerComponent({
    Key? key,
    this.onChanged,
    required this.route,
  }) : super(key: key);

  final AddressChangedCallback? onChanged;
  final _JapanesePrefecturePickerRoute route;

  @override
  State<StatefulWidget> createState() =>
      _JapanesePrefecturePickerComponentState();
}

class _JapanesePrefecturePickerComponentState
    extends State<_JapanesePrefecturePickerComponent> {
  late FixedExtentScrollController leftScrollCtrl,
      middleScrollCtrl,
      rightScrollCtrl;

  @override
  void initState() {
    super.initState();
    // refreshScrollOffset();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
        animation: widget.route.animation!,
        builder: (BuildContext context, Widget? child) {
          final double bottomPadding = MediaQuery.of(context).padding.bottom;
          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _JapanesePrefecturePickerLayout(
                widget.route.animation!.value,
                theme: widget.route.theme,
                bottomPadding: bottomPadding,
                showHeader: widget.route.showHeader,
              ),
              child: GestureDetector(
                child: Material(
                  child: Column(
                    children: [
                      widget.route.showHeader
                          ? widget.route.header
                          : Container(),
                      JapanesePrefecturePickerView(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Pickerのレイアウト
class _JapanesePrefecturePickerLayout extends SingleChildLayoutDelegate {
  final JapanesePrefecturePickerTheme theme;
  final double progress;
  final double bottomPadding;
  final bool showHeader;

  _JapanesePrefecturePickerLayout(
    this.progress, {
    required this.theme,
    this.bottomPadding = 0,
    required this.showHeader,
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeight;
    if (showHeader) maxHeight += theme.titleHeight;

    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: maxHeight + bottomPadding,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final height = size.height - childSize.height * progress;
    return Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_JapanesePrefecturePickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
