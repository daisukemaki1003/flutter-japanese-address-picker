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
    int? initialPrefectureId,
    int? initialCityId,
    AddressChangedCallback? onChanged,
    JapaneseAddressPickerTheme? theme,
  }) async {
    final addresses = await loadAddresses();
    return await Navigator.push<Address>(
      context,
      _JapaneseAddressPickerRoute(
        showHeader: showHeader,
        onChanged: onChanged,
        theme: theme ?? JapaneseAddressPickerTheme(),
        barrierLabel: MaterialLocalizations.of(
          context,
        ).modalBarrierDismissLabel,
        addressPickerController: AddressPickerController(
          addresses,
          initialPrefectureId: initialPrefectureId,
          initialCityId: initialCityId,
        ),
      ),
    );
  }
}

// ignore: unused_element
class _JapaneseAddressPickerRoute<T> extends PopupRoute<T> {
  _JapaneseAddressPickerRoute({
    required this.showHeader,
    this.onChanged,
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
        child: _JapaneseAddressPickerComponent(
          route: this,
          onChanged: onChanged,
          controller: addressPickerController,
        ),
      ),
    );
  }
}

class _JapaneseAddressPickerComponent extends StatefulWidget {
  const _JapaneseAddressPickerComponent({
    required this.route,
    required this.onChanged,
    required this.controller,
  });

  final AddressChangedCallback? onChanged;
  final _JapaneseAddressPickerRoute route;
  final AddressPickerController controller;

  @override
  State<StatefulWidget> createState() => _JapaneseAddressPickerState();
}

class _JapaneseAddressPickerState
    extends State<_JapaneseAddressPickerComponent> {
  get route => widget.route;
  get theme => route.theme;
  AddressPickerController get controller => widget.controller;

  FixedExtentScrollController? prefScrollController;
  FixedExtentScrollController? cityScrollController;

  @override
  void initState() {
    super.initState();
    refreshScrollOffset();
  }

  void refreshScrollOffset() {
    prefScrollController = FixedExtentScrollController(
      initialItem: controller.getSelectedPrefectureIndex(),
    );
    cityScrollController = FixedExtentScrollController(
      initialItem: controller.getSelectedCityIndex(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedBuilder(
        animation: route.animation!,
        builder: (BuildContext context, Widget? child) {
          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _JapaneseAddressPickerLayout(
                theme: theme,
                showHeader: route.showHeader,
                progress: route.animation!.value,
                bottomPadding: MediaQuery.of(context).padding.bottom,
              ),
              child: GestureDetector(
                child: Material(
                  child: _japaneseAddressPickerView(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _japaneseAddressPickerView() {
    return Column(
      children: [
        JapaneseAddressPickerHeader(
          theme: theme,
          onCansel: () => Navigator.pop(context),
          onSave: () => Navigator.pop(context, controller.selected),
        ),
        Expanded(
          child: Row(children: [
            JapaneseAddressPickerViewItem(
              valueKey: ValueKey(controller.selected?.prefecture.id),
              addresses: controller.prefectures,
              scrollController: prefScrollController,
              selectedChangedWhenScrolling: controller.selectedPrefecture,
              selectedChangedWhenScrollEnd: (address) {
                setState(() {
                  controller.setCites(address.id);
                  refreshScrollOffset();
                  _notifyDateChanged();
                });
              },
            ),
            JapaneseAddressPickerViewItem(
              valueKey: ValueKey(controller.selected?.prefecture.id),
              addresses: controller.cites,
              scrollController: cityScrollController,
              selectedChangedWhenScrolling: controller.selectedCity,
              selectedChangedWhenScrollEnd: (address) {
                setState(() {
                  _notifyDateChanged();
                });
              },
            ),
          ]),
        ),
      ],
    );
  }

  void _notifyDateChanged() {
    if (controller.selected != null) {
      widget.onChanged?.call(controller.selected!);
    }
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
