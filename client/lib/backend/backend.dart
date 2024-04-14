import 'dart:convert';
import 'package:funtree/core/map/map.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
}

class Api {
  // static String baseUrl = "https://89647e1c-59a8-41e4-bb5f-e6c75191a04a.mock.pstmn.io/api/";
  static String baseUrl = "http://192.168.40.222:3000/api/";

   Future<Map<String, dynamic>?> getData(String path) async {
    final Uri uri = Uri.parse(baseUrl + path);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response = await http.get(uri, headers: headers);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> jsonDataList = jsonDecode(response.body);
        return jsonDataList;
      } else {
        print('Có lỗi xảy ra: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Lỗi: $e');
      return null;
    }
  }

   Future<Map<String, dynamic>?> postData(String path, Map<String, dynamic> data) async {
    final Uri uri = Uri.parse(baseUrl + path);
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };
      final http.Response response = await http.post(uri, headers: headers, body: jsonEncode(data));
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> jsonDataList = jsonDecode(response.body);
        return jsonDataList;
      } else {
        print('Có lỗi xảy ra: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Lỗi: $e');
      return null;
    }
  }
}