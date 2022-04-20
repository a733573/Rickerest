import 'package:get/get.dart';
import 'package:rickerest/app/modules/settings/controllers/edit_profile_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => HomeController())
      ..lazyPut(() => EditProfileController());
  }
}
