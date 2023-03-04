# Japanese prefecture picker
Picker to select prefectures in Japan\
日本の都道府県を選択することができるピッカーを提供します。

## Demo
```
TODO
```

#### Features
- You can select a city in Japan.
- You can select a prefecture in Japan.
- This widget is available as a bottom sheet
- The data we provide is not limited to t prefectures!
Offline parameters can be added

## Getting started
1. Add the package to your pubspec.yaml:
```
japanese_prefecture_picker: <latest>
```

2. In your dart file, import the library:
```
import 'package:japanese_prefecture_picker/japanese_prefecture_picker.dart';
```

## Parameters:

|  Option  |  Description  |
| ---- | ---- |
|  enableOffline  |  Add an offline item.<br>Users can select offline as well as prefectures. |
|  initialValue  |  Set the initial value.<br>Enter the ID of the prefecture you want to set.<br>For the ID of each prefecture or municipality, please refer to the Ministry of Internal Affairs and Communications' prefectural code or municipal code.<br>https://www.soumu.go.jp/denshijiti/code.html|
|  allowUnselectedCity  |  Allow unselected city.<br>If enabled, allows selection of prefectures only.  |

