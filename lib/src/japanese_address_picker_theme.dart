import 'package:flutter/material.dart';

class JapaneseAddressPickerTheme {
  /// -------- overall --------
  final double containerHeight;
  final double headerHeight;
  final double itemHeight;

  /// -------- header --------
  final Color headerColor;

  final String headerTitle;
  final String headerCansel;
  final String headerSave;

  final TextStyle headerTitleStyle;
  final TextStyle headerCanselStyle;
  final TextStyle headerSaveStyle;

  /// -------- body --------
  final Color bodyColor;
  final TextStyle itemStyle;

  JapaneseAddressPickerTheme({
    this.containerHeight = 250.0,
    this.headerHeight = 45.0,
    this.itemHeight = 36.0,
    this.headerColor = const Color(0xFFEEEEEE),
    this.headerTitle = "",
    this.headerCansel = "キャンセル",
    this.headerSave = "保存",
    this.headerTitleStyle = const TextStyle(
      color: Colors.black54,
      fontSize: 16,
    ),
    this.headerCanselStyle = const TextStyle(
      color: Colors.black54,
      fontSize: 14,
    ),
    this.headerSaveStyle = const TextStyle(
      color: Colors.blue,
      fontSize: 14,
    ),
    this.bodyColor = Colors.white,
    this.itemStyle = const TextStyle(
      color: Color(0xFF000046),
      fontSize: 16,
    ),
  });
}
