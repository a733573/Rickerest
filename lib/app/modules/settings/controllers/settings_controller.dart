import 'package:get/get.dart';

import '../../../data/model/settings_model.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  final SettingsModel settingsModel = SettingsModel();
}
