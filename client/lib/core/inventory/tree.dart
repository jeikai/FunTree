import 'package:funtree/backend/backend.dart';
import 'package:funtree/core/SharePref.dart';
import 'package:funtree/core/utils/image_constant.dart';
import 'package:uuid/uuid.dart';

class Tree {
  String id;
  String uuid;
  String name;
  String address;
  String temperature;
  String aqi;
  String humidity;
  String wind;
  String imagePath;
  String notificationImagePath;

  Tree(
      {this.id = "1",
      this.name = "Tree",
      this.address = "Address",
      this.temperature = "29°",
      this.aqi = "112",
      this.humidity = "95%",
      this.wind = "13 km/h",
      String? imagePath,
      String? notificationImagePath})
      : imagePath = imagePath ?? ImageConstant.imgTree,
        notificationImagePath =
            notificationImagePath ?? ImageConstant.imgNotification,
        uuid = Uuid().v4();

  @override
  String toString() {
    return 'Tree{name: $name, address: $address, temperature: $temperature, aqi: $aqi, humidity: $humidity, wind: $wind, imagePath: $imagePath, notificationImagePath: $notificationImagePath}';
  }
}

List<Tree> treeList = [
  Tree(
      name: "Fun Tree 1",
      address: "Hanoi",
      temperature: "29°",
      aqi: "112",
      humidity: "95%",
      wind: "13 km/h")
];

Future<void> getData() async {
  try {
    var response = await Api().getData('plant');
    for (var item in response!["response"]) {
      String name = item['name'] ?? "Tree";
      String imagePath = item['url'] ?? ImageConstant.imgTree;
      int AQI = 0;
      int humidity = 0;
      double wind = 0.00;
      double temp = 0.0;
      String currentAddress = "";
      temp = (await SharePref.getTemp())!;
      AQI = (await SharePref.getAqi()!);
      humidity = (await SharePref.getHumidity()!);
      wind = (await SharePref.getWind()!);
      currentAddress = (await SharePref.getAdress())!;
      Tree tree = Tree(
          name: name,
          address: currentAddress,
          temperature: temp as String,
          aqi: AQI as String,
          humidity: humidity as String,
          wind: wind as String,
          imagePath: imagePath);
      treeList.add(tree);
    }
    print(treeList);
    print("hioii");
  } catch (e) {
    print(e);
  }
}

List<int> _isPlaced = [];

bool isPlaced(int index) {
  if (!_isPlaced.contains(index)) return false;
  return true;
}

void setPlaced(int index) {
  if (_isPlaced.contains(index)) return;
  _isPlaced.add(index);
}
