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
              onPressed: () => _showButtomPicker(context),
              child: const Text('Open picker'),
            ),
          ),
        ],
      ),
    );
  }

  _showButtomPicker(BuildContext context) async {
    final address = await JapaneseAddressPicker.showBottomSheet(
      context,
      initialValue: AddressValue(
        prefectureId: 1,
        cityId: 40,
      ),
      onChanged: (address) {
        print(address.prefecture.name);
        print(address.city.name);
      },
    );
    if (address != null) {
      print(address.prefecture.name);
      print(address.city.name);
    } else {
      print("no response");
    }
  }
}
