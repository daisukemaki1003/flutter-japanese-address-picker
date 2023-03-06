import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/src/data/address.dart';
import 'package:japanese_prefecture_picker/src/japanese_prefecture_picker_controller.dart';
import 'package:japanese_prefecture_picker/src/japanese_prefecture_picker_theme.dart';
import 'package:japanese_prefecture_picker/src/widgets/japanese_prefecture_picker_header.dart';
import 'package:japanese_prefecture_picker/src/widgets/japanese_prefecture_picker_view.dart';

typedef AddressChangedCallback = Function(Address address);

class JapanesePrefecturePicker {
  /// [showHeader]ボトムソートにヘッダーを表示するか
  /// falseの場合はヘッダーを表示しない
  static Future<Address?> showBottomSheet(
    BuildContext context, {
    bool showHeader = true,
    VoidCallback? onCancel,
    AddressChangedCallback? onChanged,
    JapanesePrefecturePickerTheme? theme,
  }) async {
    return await Navigator.push<Address>(
      context,
      _JapanesePrefecturePickerRoute(
        showHeader: showHeader,
        onChanged: onChanged,
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
    this.onChanged,
    this.barrierLabel,
    required this.theme,
    RouteSettings? settings,
  }) : super(settings: settings);

  /// ヘッダーを表示するかどうか
  /// 初期値はtrueで設定しています
  final bool showHeader;

  /// ピッカー項目間を移動するときに呼び出されるNullable関数
  /// 選択された都道府県市データを返します
  final AddressChangedCallback? onChanged;

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
        child: _JapanesePrefecturePickerComponent(this),
      ),
    );
  }
}

class _JapanesePrefecturePickerComponent extends StatefulWidget {
  const _JapanesePrefecturePickerComponent(this.route, {Key? key})
      : super(key: key);

  final _JapanesePrefecturePickerRoute route;
  // FixedExtentScrollController leftScrollCtrl, middleScrollCtrl, rightScrollCtrl;

  @override
  State<StatefulWidget> createState() =>
      _JapanesePrefecturePickerComponentState();
}

class _JapanesePrefecturePickerComponentState
    extends State<_JapanesePrefecturePickerComponent> {
  @override
  void initState() {
    super.initState();
    // refreshScrollOffset();
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.route.theme;

    return AnimatedBuilder(
      animation: widget.route.animation!,
      builder: (BuildContext context, Widget? child) {
        return CustomSingleChildLayout(
          delegate: _JapanesePrefecturePickerLayout(
            theme: theme,
            progress: widget.route.animation!.value,
            bottomPadding: MediaQuery.of(context).padding.bottom,
            showHeader: widget.route.showHeader,
          ),
          child: JapanesePrefecturePickerController(
            builder: (address, prefectures, cites, onChange) {
              return Column(
                children: [
                  JapanesePrefecturePickerHeader(
                    theme: theme,
                    onCansel: () => Navigator.pop(context),
                    onSave: () => Navigator.pop(context, address),
                  ),
                  JapanesePrefecturePickerView(
                    theme: theme,
                    address: address,
                    prefectures: prefectures,
                    cites: cites,
                    onChange: onChange,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

/// Pickerのレイアウト
class _JapanesePrefecturePickerLayout extends SingleChildLayoutDelegate {
  final JapanesePrefecturePickerTheme theme;
  final double progress;
  final double bottomPadding;
  final bool showHeader;

  _JapanesePrefecturePickerLayout({
    required this.theme,
    required this.progress,
    this.bottomPadding = 0,
    required this.showHeader,
  });

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeight;
    if (showHeader) maxHeight += theme.headerHeight;

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
