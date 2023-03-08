import 'package:flutter/material.dart';
import 'package:flutter_japanese_address_picker/src/address_model.dart';
import 'package:flutter_japanese_address_picker/src/address_picker_model.dart';
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
    AddressValue? initialValue,
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
        model: AddressPickerModel(
          addresses,
          initialValue ?? AddressValue(),
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
    required this.theme,
    required this.model,
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

  final AddressPickerModel model;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => 'Dismiss this dialog';

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
        child: _JapaneseAddressPicker(this),
      ),
    );
  }
}

class _JapaneseAddressPicker extends StatefulWidget {
  const _JapaneseAddressPicker(this.route);

  final _JapaneseAddressPickerRoute route;

  @override
  State<StatefulWidget> createState() => _JapaneseAddressPickerState();
}

class _JapaneseAddressPickerState extends State<_JapaneseAddressPicker> {
  _JapaneseAddressPickerRoute get route => widget.route;
  JapaneseAddressPickerTheme get theme => route.theme;
  AddressPickerModel get model => route.model;

  FixedExtentScrollController? prefScrollController;
  FixedExtentScrollController? cityScrollController;

  @override
  void initState() {
    refreshScroll();
    super.initState();
  }

  void onChangeAddress() {
    if (model.selected == null) return;
    route.onChanged?.call(model.selected!);
  }

  void refreshScroll() {
    prefScrollController = FixedExtentScrollController(
      initialItem: model.getSelectedPrefectureIndex(),
    );
    cityScrollController = FixedExtentScrollController(
      initialItem: model.getSelectedCityIndex(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: route.animation!,
      builder: (BuildContext context, _) {
        return CustomSingleChildLayout(
          delegate: _JapaneseAddressPickerLayout(
            theme: theme,
            showHeader: route.showHeader,
            progress: route.animation!.value,
            bottomPadding: MediaQuery.of(context).padding.bottom,
          ),
          child: Material(
            child: Column(
              children: [
                JapaneseAddressPickerHeader(
                  theme: theme,
                  onCansel: () => Navigator.pop(context),
                  onSave: () => Navigator.pop(context, model.selected),
                ),
                Expanded(
                  child: Row(children: [
                    JapaneseAddressPickerViewItem(
                      valueKey: ValueKey(model.selected?.prefecture.id),
                      addresses: model.prefectures,
                      scrollController: prefScrollController,
                      onSelectedItemChanged: model.selectedPrefecture,
                      onSelectedItemChangedWhenScrollEnd: (address) {
                        setState(() {
                          model.setCites(address.id);
                          refreshScroll();
                          onChangeAddress();
                        });
                      },
                    ),
                    JapaneseAddressPickerViewItem(
                      valueKey: ValueKey(model.selected?.prefecture.id),
                      addresses: model.cites,
                      scrollController: cityScrollController,
                      onSelectedItemChanged: model.selectedCity,
                      onSelectedItemChangedWhenScrollEnd: (address) {
                        setState(() => onChangeAddress());
                      },
                    ),
                  ]),
                ),
              ],
            ),
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
