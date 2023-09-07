
import 'package:shared_preferences/shared_preferences.dart';

class LocationPref {
  SharedPreferences? _prefs;

  Future<void> setPosition(String path,) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setString("position",path);
  }

  Future<String> getPosition() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getString("position") ?? "";
  }

  Future<void> setName(String name) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setString("name", name);
  }

  Future<String> getName() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getString("name") ?? "";
  }

  Future<void> setPhone(String phone) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setString("phone", phone);
  }

  Future<String> getPhone() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getString("phone") ?? "";
  }

  Future<void> setDate(String date) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setString("date", date);
  }

  Future<String> getDate() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getString("date") ?? "";
  }

  Future<void> setLang(bool lang) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setBool("lang",lang);
  }

  Future<bool> getLang() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getBool("lang") ?? false;
  }

  Future<void> setIsFirst(bool mode) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setBool('first', mode);
  }

  Future<bool> getIsFirst() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getBool('first') ?? true;
  }

  Future<void> setIsLogged(bool logged) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setBool('logged', logged);
  }

  Future<bool> getIsLogged() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getBool('logged') ?? false;
  }

  Future<void> setOrderNumber(int value) async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs?.setInt('orderNumber', value);
  }

  Future<int> getOrderNumber() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs?.getInt('orderNumber') ?? 1;
  }


}