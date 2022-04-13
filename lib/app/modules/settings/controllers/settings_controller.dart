import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/theme/app_theme.dart';

import '../../../data/model/settings_model.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  final SettingsModel settingsModel = SettingsModel();

  final RxBool _isDarkMode = Get.isDarkMode.obs;

  bool get isDarkMode => _isDarkMode.value;

  void updateIsDarkMode() {
    if (settingsModel.currentThemeModeIndex == ThemeModeIndex.dark) {
      _isDarkMode.value = true;
    } else if (settingsModel.currentThemeModeIndex == ThemeModeIndex.light) {
      _isDarkMode.value = false;
    } else if (Get.isPlatformDarkMode) {
      _isDarkMode.value = true;
    } else {
      _isDarkMode.value = false;
    }
  }

  ThemeData get currentThemeData =>
      _isDarkMode.value ? AppTheme.dark : AppTheme.light;
}
