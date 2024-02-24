import 'dart:convert';
import 'package:funtree/core/map/map.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveMaps() {
  // Save maps to local storage
  SharedPreferences.getInstance().then((prefs) {
    String json = jsonEncode(maps);
    prefs.setString('mapsData', json);
  });
  // Save maps to cloud storage
}

void loadMap() {
  // Load maps from local storage
  SharedPreferences.getInstance().then((prefs) {
    String? json = prefs.getString('mapsData');
    if (json != null) {
      List<dynamic> data = jsonDecode(json);
      maps = data.map<TreeMap>((e) => TreeMap.fromJson(e)).toList();
    }
  });
  // Load maps from cloud storage
}