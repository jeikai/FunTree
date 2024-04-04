import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  static SharedPreferences? _preferences;
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }
  static Future setTemp(double temp) async =>
      await _preferences?.setDouble("temp", temp);

  static double? getTemp() => _preferences?.getDouble("temp");

  static Future setAqi(int AQI) async =>
      await _preferences?.setInt("AQI", AQI);

  static int? getAqi() => _preferences?.getInt("AQI");

  static Future setHumidity(int humid) async =>
      await _preferences?.setInt("humidity", humid);

  static int? getHumidity() => _preferences?.getInt("humidity");

  static Future setWind(double wind) async =>
      await _preferences?.setDouble("wind", wind);

  static double? getWind() => _preferences?.getDouble("wind");

  static Future setLangtitude(double langtitude) async =>
      await _preferences?.setDouble("langtitude", langtitude);

  static double? getLangtitude() => _preferences?.getDouble("langtitude");

  static Future setLongtitude(double longtitude) async =>
      await _preferences?.setDouble("longtitude", longtitude);

  static double? getLongtitude() => _preferences?.getDouble("longtitude");

  static Future setAddress(String address) async =>
      await _preferences?.setString("address", address);

  static String? getAdress() => _preferences?.getString("address");
}