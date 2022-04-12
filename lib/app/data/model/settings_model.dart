import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsModel {
  SettingsModel() {
    _themeModeIndex.value = _box.read('themeModeIndex') ?? 0;
  }

  final _box = GetStorage();
  final RxInt _themeModeIndex = 0.obs;

  int get themeModeIndex => _themeModeIndex.value;

  set themeModeIndex(int value) {
    if (_themeModeIndex.value == value || value > 2) {
      return;
    }
    _themeModeIndex.value = value;
    _box.write('themeModeIndex', value);
    Get.changeThemeMode(ThemeMode.values[value]);
    // SettingsController.to.updateIsDarkMode;
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
