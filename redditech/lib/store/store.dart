import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  void storeValue(String key, var value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value.runtimeType == int) {
      await prefs.setInt(key, value);
    } else {
      await prefs.setString(key, value);
    }
  }

  Future<dynamic> getValue(String key, Type type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if (type == int) {
        return (prefs.getInt(key)!.toInt());
      } else {
        return (prefs.getString(key).toString());
      }
    } catch (e) {
      return (type == String ? '' : 0);
    }
  }
}
