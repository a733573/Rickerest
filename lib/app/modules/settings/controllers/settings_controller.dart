import 'package:get/get.dart';

import '../../../data/model/settings_model.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  late final SettingsModel settingsModel;

  Future<void> initModel() async {
    settingsModel = SettingsModel();
    await settingsModel.init();
  }
}
