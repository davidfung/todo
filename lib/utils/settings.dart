import 'package:shared_preferences/shared_preferences.dart';

Future<int> loadIntSettings(String key, {int defaultValue}) async {
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
  print("_loadIntSettings() $_value");
  return _value;
}

void saveIntSettings(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
  print("_saveIntSettings() $value");
}
