import 'package:get/get.dart';
import 'package:rickerest/app/core/utils/user_util.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final RxMap<String, String> currentUserData =
      {'name': '', 'avatarImageUrl': ''}.obs;

  // final List<Map<String, RxString>> friendsData = []
  @override
  Future<void> onInit() async {
    super.onInit();

    final Map<String, String>? data = await getCurrentUserProfileData;
    if (data != null) {
      currentUserData.value = data;
    }
  }
}
