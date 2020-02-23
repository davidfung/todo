import 'package:shared_preferences/shared_preferences.dart';

Future<int> loadInt(String key, {int defaultValue}) async {
  int _value;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    _value = prefs.getInt(key);
  } catch (e) {
    _value = defaultValue;
  }
  if (_value == null) {
    _value = defaultValue;
  }
  print("_loadInt() $_value");
  return _value;
}

Future<void> saveInt(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
  print("_saveInt() $value");
}

Future<String> loadString(String key, {String defaultValue}) async {
  String _value;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    _value = prefs.getString(key);
  } catch (e) {
    _value = defaultValue;
  }
  if (_value == null) {
    _value = defaultValue;
  }
  print("_loadString() $_value");
  return _value;
}

Future<void> saveString(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
  print("_saveString() $value");
}