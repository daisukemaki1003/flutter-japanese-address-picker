import 'package:flutter/material.dart';
import 'package:japanese_prefecture_picker/japanese_prefecture_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const Scaffold(
        body: ExampleApp(),
      ),
    );
  }
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  final buttonWidth = 300.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF6F2F2),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: buttonWidth,
            child: ElevatedButton(
              onPressed: () => _showButtomPicker(context),
              child: const Text('Open picker'),
            ),
          ),
        ],
      ),
    );
  }

  _showButtomPicker(BuildContext context) {
    // DatePicker.showPicker(
    //   context,
    //   showTitleActions: true,
    //   locale: LocaleType.jp,
    //   onConfirm: (date) {},
    // );
    JapanesePrefecturePicker(
      header: JapanesePrefecturePickerHeader(
        title: const Text('タイトル', style: TextStyle(fontSize: 16)),
        leading: TextButton(
          onPressed: () {},
          child: const Text('キャンセル', style: TextStyle(fontSize: 14)),
        ),
        trailing: TextButton(
          onPressed: () {},
          child: const Text('保存', style: TextStyle(fontSize: 14)),
        ),
      ),
    ).show(context);
  }
}
