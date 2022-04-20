import 'package:get/get.dart';
import 'package:rickerest/app/modules/settings/controllers/edit_profile_controller.dart';

import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => SettingsController())
      ..lazyPut(() => EditProfileController());
  }
}
