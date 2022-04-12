import 'package:get/get.dart';

import '../../../data/model/settings_model.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  final SettingsModel settingsModel = SettingsModel();
  bool isDarkMode = Get.isDarkMode;

// void updateIsDarkMode() {
//   if (settingsModel.themeModeIndex == ThemeMode.dark.toInt()) {
//     isDarkMode = true;
//     print(true);
//   } else if (settingsModel.themeModeIndex == ThemeMode.light.toInt()) {
//     isDarkMode = false;
//     print(false);
//   } else if (Get.isPlatformDarkMode) {
//     // isDarkMode = false;
//     print('else');
//   }
// }
}
