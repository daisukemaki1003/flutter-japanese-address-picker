import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_japanese_address_picker/flutter_japanese_address_picker.dart';

const jsonPath =
    'packages/flutter_japanese_address_picker/assets/address_seeds.json';

Future<List<AddressesModel>> loadAddresses() async {
  final json = await rootBundle.loadString(jsonPath);
  return (jsonDecode(json) as List).map((decode) {
    return AddressesModel.fromJson(decode);
  }).toList();
}
