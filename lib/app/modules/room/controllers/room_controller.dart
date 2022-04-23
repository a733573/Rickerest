import 'package:get/get.dart';
import 'package:rickerest/app/data/models/room.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

class RoomController extends GetxController {
  RoomController get to => Get.find();

  final currentChatUser = FirestoreService.to.currentUser!.toChatUser;

  final Room room = Get.arguments as Room;

  @override
  void onInit() {
    super.onInit();
  }
}
