import 'package:flutter/material.dart';
import 'package:flutter_japanese_address_picker/src/address_model.dart';
import 'package:flutter_japanese_address_picker/src/address_picker_controller.dart';
import 'package:flutter_japanese_address_picker/src/address_util.dart';
import 'package:flutter_japanese_address_picker/src/japanese_address_picker_theme.dart';
import 'package:flutter_japanese_address_picker/src/widgets/japanese_address_picker_header.dart';
import 'package:flutter_japanese_address_picker/src/widgets/japanese_address_picker_view_item.dart';

typedef AddressChangedCallback = Function(Address address);

class JapaneseAddressPicker {
  /// [showHeader]ボトムソートにヘッダーを表示するか
  /// falseの場合はヘッダーを表示しない
  static Future<Address?> showBottomSheet(
    BuildContext context, {
    bool showHeader = true,
    int? prefectureId,
    int? cityId,
    AddressChangedCallback? onChanged,
    JapaneseAddressPickerTheme? theme,
  }) async {
    final addresses = await loadAddresses();
    return await Navigator.push<Address>(
      context,
      _JapaneseAddressPickerRoute(
        showHeader: showHeader,
        initialPrefectureId: prefectureId,
        initialCityId: cityId,
        onChanged: onChanged,
        theme: theme ?? JapaneseAddressPickerTheme(),
        barrierLabel: MaterialLocalizations.of(
          context,
        ).modalBarrierDismissLabel,
        addressPickerController: AddressPickerController(addresses),
      ),
    );
  }
}

// ignore: unused_element
class _JapaneseAddressPickerRoute<T> extends PopupRoute<T> {
  _JapaneseAddressPickerRoute({
    required this.showHeader,
    this.onChanged,
    this.initialPrefectureId,
    this.initialCityId,
    this.barrierLabel,
    required this.theme,
    required this.addressPickerController,
    RouteSettings? settings,
  }) : super(settings: settings);

  /// ヘッダーを表示するかどうか
  /// 初期値はtrueで設定しています
  final bool showHeader;

  /// ピッカー項目間を移動するときに呼び出されるNullable関数
  /// 選択された都道府県市データを返します
  final AddressChangedCallback? onChanged;

  /// 初期値
  final int? initialPrefectureId;
  final int? initialCityId;

  /// [JapaneseAddressPickerTheme]のスタイルを制御
  final JapaneseAddressPickerTheme theme;

  final AddressPickerController addressPickerController;

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
        child: _JapaneseAddressPickerComponent(this),
      ),
    );
  }
}

class _JapaneseAddressPickerComponent extends StatefulWidget {
  _JapaneseAddressPickerComponent(this.route, {Key? key}) : super(key: key);

  final _JapaneseAddressPickerRoute route;

  @override
  State<StatefulWidget> createState() => _JapaneseAddressPickerComponentState();
}

class _JapaneseAddressPickerComponentState
    extends State<_JapaneseAddressPickerComponent> {
  get theme => widget.route.theme;
  AddressPickerController get controller =>
      widget.route.addressPickerController;

  @override
  void initState() {
    controller.setPrefScrollController(FixedExtentScrollController(
      initialItem: widget.route.initialPrefectureId ?? 0,
    ));
    controller.setCityScrollController(FixedExtentScrollController(
      initialItem: widget.route.initialCityId ?? 0,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.route.animation!,
      builder: (BuildContext context, Widget? child) {
        return CustomSingleChildLayout(
          delegate: _JapaneseAddressPickerLayout(
            theme: theme,
            progress: widget.route.animation!.value,
            bottomPadding: MediaQuery.of(context).padding.bottom,
            showHeader: widget.route.showHeader,
          ),
          child: Column(
            children: [
              JapaneseAddressPickerHeader(
                theme: theme,
                onCansel: () => Navigator.pop(context),
                onSave: () => Navigator.pop(context, controller.selected),
              ),
              Expanded(
                child: Row(children: [
                  JapaneseAddressPickerViewItem(
                    addresses: controller.prefectures,
                    scrollController: controller.prefScrollController,
                    onChange: (value) => controller.selectedPrefecture(value),
                  ),
                  JapaneseAddressPickerViewItem(
                    addresses: controller.cites,
                    scrollController: controller.cityScrollController,
                    onChange: (value) => controller.selectedCity(value),
                  ),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Pickerのレイアウト
class _JapaneseAddressPickerLayout extends SingleChildLayoutDelegate {
  final JapaneseAddressPickerTheme theme;
  final double progress;
  final double bottomPadding;
  final bool showHeader;

  _JapaneseAddressPickerLayout({
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
  bool shouldRelayout(_JapaneseAddressPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
