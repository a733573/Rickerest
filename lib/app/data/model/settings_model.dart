import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel {
  late final SharedPreferences _prefs;
  final RxInt _themeModeIndex = 0.obs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _themeModeIndex.value = _prefs.getInt('themeModeIndex') ?? 0;
  }

  int get themeModeIndex => _themeModeIndex.value;

  Future<void> setThemeModeIndex(int value) async {
    if (_themeModeIndex.value == value || value > 2) {
      return;
    }
    _themeModeIndex.value = value;
    await _prefs.setInt('themeModeIndex', value);
    Get.changeThemeMode(ThemeMode.values[value]);
  }
}

extension ThemeModeExtension on ThemeMode {
  int toInt() {
    switch (this) {
      case ThemeMode.system:
        return 0;
      case ThemeMode.light:
        return 1;
      case ThemeMode.dark:
        return 2;
    }
  }
}
