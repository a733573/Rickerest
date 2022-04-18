import 'package:get/get.dart';
import 'package:rickerest/app/modules/home/controllers/add_friends_controller.dart';

class AddFriendsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddFriendsController());
  }
}
