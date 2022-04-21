import 'package:get/get.dart';
import 'package:rickerest/app/modules/home/controllers/add_friends_controller.dart';
import 'package:rickerest/app/modules/settings/controllers/edit_profile_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => HomeController(), fenix: true)
      ..lazyPut(() => AddFriendsController(), fenix: true)
      ..lazyPut(() => EditProfileController(), fenix: true);
  }
}
