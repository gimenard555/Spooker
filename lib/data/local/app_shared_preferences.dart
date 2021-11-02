import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  SharedPreferences? _preferences;

  Future<SharedPreferences> getInstance() async {
    return _preferences ??= await SharedPreferences.getInstance();
  }
}
