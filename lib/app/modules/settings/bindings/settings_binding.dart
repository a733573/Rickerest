import 'package:get/get.dart';

import '../../../global/controllers/auth_controller.dart';
import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<SettingsController>(() => SettingsController())
      ..lazyPut<AuthController>(() => AuthController());
  }
}
