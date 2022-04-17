import 'package:get/get.dart';
import 'package:rickerest/app/global/controllers/user_controller.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final RxMap<String, String> currentUserData = {'': ''}.obs;

  // final List<Map<String, RxString>> friendsData = []
  @override
  Future<void> onInit() async {
    super.onInit();

    final Map<String, String>? data =
        await UserController.to.getCurrentUserProfileData;
    if (data != null) {
      currentUserData.value = data;
    }
  }
}
