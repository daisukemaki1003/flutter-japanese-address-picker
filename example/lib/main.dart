import 'package:flutter/material.dart';
import 'package:flutter_japanese_address_picker/flutter_japanese_address_picker.dart';

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
              onPressed: () async {
                await JapaneseAddressPicker.show(
                  context,
                  showHeader: true,
                  theme: JapaneseAddressPickerTheme(headerTitle: "居住地"),
                  initialValue: const AddressModel(
                    prefecture: '北海道',
                    city: '函館市',
                  ),
                );
              },
              child: const Text('Open picker'),
            ),
          ),
        ],
      ),
    );
  }
}
