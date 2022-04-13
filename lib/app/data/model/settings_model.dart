import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../modules/settings/controllers/settings_controller.dart';

class SettingsModel {
  SettingsModel() {
    _currentThemeModeIndex.value =
        _box.read('themeModeIndex') ?? ThemeModeIndex.system;
  }

  final _box = GetStorage();
  final RxInt _currentThemeModeIndex = 0.obs;

  int get currentThemeModeIndex => _currentThemeModeIndex.value;

  set currentThemeModeIndex(int value) {
    if (_currentThemeModeIndex.value == value || value > 2) {
      return;
    }
    _currentThemeModeIndex.value = value;
    _box.write('themeModeIndex', value);
    Get.changeThemeMode(ThemeMode.values[value]);
    SettingsController.to.updateIsDarkMode();
  }
}

abstract class ThemeModeIndex {
  ThemeModeIndex._();
  static const int system = 0; // ThemeMode.values.indexOf(ThemeMode.system)
  static const int light = 1; // ThemeMode.values.indexOf(ThemeMode.light)
  static const int dark = 2; // ThemeMode.values.indexOf(ThemeMode.dark)
}
