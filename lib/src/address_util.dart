import 'dart:convert';

import 'package:flutter/services.dart';

Future<List> loadAddresses() async {
  return await json.decode(await rootBundle.loadString(
    'packages/flutter_japanese_address_picker/assets/address_seeds.json',
  ));
}
