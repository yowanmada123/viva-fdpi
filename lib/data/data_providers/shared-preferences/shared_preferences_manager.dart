import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  final String key;

  SharedPreferencesManager({required this.key});

  Future<void> write(String data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, data);
  }

  Future<String?> read() async {
    final prefs = await SharedPreferences.getInstance();
    final dataString = prefs.getString(key);
    // if (dataString != null) {
    //   final data = json.decode(dataString);
    //   return data;
    // }
    // return null;
    return dataString;
  }

  Future<bool> hasData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
