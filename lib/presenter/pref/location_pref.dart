
import 'package:shared_preferences/shared_preferences.dart';

class LocationPref {
  SharedPreferences? _prefs;

  Future<void> setPosition(
      String path,
      ) async {
    print("SAQLASH: ${path}");
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setString("position",path);
  }

  Future<String> getPosition() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getString("position") ?? "";
  }

  Future<void> setIsFirst(bool mode) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setBool('first', mode);
  }

  Future<bool> getIsFirst() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getBool('first') ?? true;
  }
}