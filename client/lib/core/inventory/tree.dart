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
      wind: "13 km/h"),
  Tree(
      name: "Fun Tree 2",
      address: "Hanoi",
      temperature: "29°",
      aqi: "112",
      humidity: "95%",
      wind: "13 km/h"),
  Tree(
      name: "Fun Tree 3",
      address: "Hanoi",
      temperature: "29°",
      aqi: "112",
      humidity: "95%",
      wind: "13 km/h"),
  Tree(
      name: "Fun Tree 4",
      address: "Hanoi",
      temperature: "29°",
      aqi: "112",
      humidity: "95%",
      wind: "13 km/h"),
  Tree(
      name: "Fun Tree 5",
      address: "Hanoi",
      temperature: "29°",
      aqi: "112",
      humidity: "95%",
      wind: "13 km/h"),
  Tree(
      name: "Fun Tree 6",
      address: "Hanoi",
      temperature: "29°",
      aqi: "112",
      humidity: "95%",
      wind: "13 km/h"),
  Tree(
      name: "Fun Tree 7",
      address: "Hanoi",
      temperature: "29°",
      aqi: "112",
      humidity: "95%",
      wind: "13 km/h"),
  Tree(
      name: "Fun Tree 8",
      address: "Hanoi",
      temperature: "29°",
      aqi: "112",
      humidity: "95%",
      wind: "13 km/h"),
  Tree(
      name: "Fun Tree 9",
      address: "Hanoi",
      temperature: "29°",
      aqi: "112",
      humidity: "95%",
      wind: "13 km/h"),
  Tree(
      name: "Fun Tree 10",
      address: "Hanoi",
      temperature: "29°",
      aqi: "112",
      humidity: "95%",
      wind: "13 km/h"),
];

List<int> _isPlaced = [];

bool isPlaced(int index) {
  if (!_isPlaced.contains(index)) return false;
  return true;
}

void setPlaced(int index) {
  if (_isPlaced.contains(index)) return;
  _isPlaced.add(index);
}
