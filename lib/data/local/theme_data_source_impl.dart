import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:spooker/data/local/app_shared_preferences.dart';
import 'package:spooker/data/local/theme_data_source.dart';

class ThemeDataSourceImpl extends ThemeDataSource {
  ThemeDataSourceImpl(this._preferences);

  static const String keyThemeMode = 'theme_mode';

  final AppSharedPreferences _preferences;

  @override
  Future<ThemeMode?> loadThemeMode() async {
    final preferences = await _preferences.getInstance();
    return EnumToString.fromString(
        ThemeMode.values, preferences.getString(keyThemeMode)!);
  }

  @override
  Future<void> saveThemeMode(ThemeMode? theme) async {
    final preferences = await _preferences.getInstance();
    preferences.setString(keyThemeMode, EnumToString.convertToString(theme));
  }
}
