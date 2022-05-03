import 'package:get/get.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

import '../../../routes/app_pages.dart';

class CreateRoomController extends GetxController {
  static CreateRoomController get to => Get.find();

  final checkMap = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    for (final friendUser in FirestoreService.to.friendUsers) {
      checkMap[friendUser.uid] = false;
    }
  }

  Future<void> createRoom() async {
    final checkedUids = <String>[];
    checkMap.forEach((String key, bool value) {
      if (value) {
        checkedUids.add(key);
      }
    });
    if (checkedUids.isEmpty) {
      return;
    } else if (checkedUids.length == 1) {
      await Get.toNamed(
        Routes.room,
        arguments: await FirestoreService.to.friendUsers
            .firstWhere((friendUser) => friendUser.uid == checkedUids.first)
            .personalRoom,
      );
      return Get.offNamed(Routes.chats);
    } else {
      final room = await FirestoreService.to
          .createRoom([AuthService.to.uid!, ...checkedUids]);
      await Get.toNamed(
        Routes.room,
        arguments: room,
      );
      return Get.offNamed(Routes.chats);
    }
  }
}
