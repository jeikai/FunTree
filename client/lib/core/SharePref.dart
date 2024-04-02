import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static SharedPreferences? _preferences;
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }
  static Future setTemp(String temp) async =>
      await _preferences?.setString("temp", temp);

  static String? getTemp() => _preferences?.getString("temp");

  static Future setAqi(String AQI) async =>
      await _preferences?.setString("AQI", AQI);

  static String? getAqi() => _preferences?.getString("AQI");

  static Future setHumidity(String humid) async =>
      await _preferences?.setString("humidity", humid);

  static String? getHumidity() => _preferences?.getString("humidity");

  static Future setWind(String wind) async =>
      await _preferences?.setString("wind", wind);

  static String? getWind() => _preferences?.getString("wind");

  static Future setLangtitude(String langtitude) async =>
      await _preferences?.setString("langtitude", langtitude);

  static String? getLangtitude() => _preferences?.getString("langtitude");

  static Future setLongtitude(String longtitude) async =>
      await _preferences?.setString("longtitude", longtitude);

  static String? getLongtitude() => _preferences?.getString("longtitude");

  static Future setAddress(String address) async =>
      await _preferences?.setString("address", address);

  static String? getAdress() => _preferences?.getString("address");
}