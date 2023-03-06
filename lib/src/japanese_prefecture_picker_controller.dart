import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/src/data/address.dart';

class JapanesePrefecturePickerController extends StatefulWidget {
  const JapanesePrefecturePickerController({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(Address, Function(Address) onChange) builder;

  @override
  State<StatefulWidget> createState() =>
      _JapanesePrefecturePickerControllerState();
}

class _JapanesePrefecturePickerControllerState
    extends State<JapanesePrefecturePickerController> {
  late Address address;

  changeAddress(newAddress) {
    setState(() => address = newAddress);
  }

  @override
  void initState() {
    address = Address();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(address, changeAddress);
  }
}
