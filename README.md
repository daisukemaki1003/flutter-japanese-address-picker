# Flutter Japanese address picker
日本の都道府県を選択することができるピッカーを提供します。<br>Picker to select address in Japan.

<image src="https://user-images.githubusercontent.com/68681355/223709931-aaefccde-835a-4bcc-805c-c04ed5b0242c.png" width="200" />


#### Features
- You can select a prefecture in Japan.
- You can select a city in Japan.
- This widget is available as a bottom sheet

## Getting started
1. Add the package to your pubspec.yaml:
```
flutter_japanese_address_picker: <latest>
```

2. In your dart file, import the library:
```
import 'package:flutter_japanese_address_picker/flutter_japanese_address_picker.dart';
```

## Parameters:

|  Option  |  Description  |
| ---- | ---- |
|  showHeader  | Display the header in the picker.<br>If set to false, the header will not be displayed. |
|  initialValue  |  Set the initial value.<br>Please enter the ID of the prefecture or municipality you want to set or the name of the place.<br>For the ID of each prefecture or municipality, please refer to the Ministry of Internal Affairs and Communications' prefectural code or municipal code.<br>https://www.soumu.go.jp/denshijiti/code.html |
|  theme  |  Manage the size, style, etc. of the Flutter Japanese address picker.<br>You can also set the text that appears in the header from here.  |
|  onChanged  |  You can get the selected address data.  |
|  isAllowUnselectedPrefecture  |  Whether to allow unselected prefecture data.  |
|  isAllowUnselectedCity  |  Whether to allow unselected city data.  |



