import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/data/models/message.dart';
import 'package:rickerest/app/data/models/room.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

class RoomController extends GetxController {
  RoomController get to => Get.find();

  final currentChatUser = FirestoreService.to.currentUser!.toChatUser();

  final Room room = Get.arguments as Room;

  Future<void> sendMessage(ChatMessage m) async {
    await FirestoreService.to.addDoc(
      ref: FirestoreService.to.db
          .collection('rooms')
          .doc(room.id)
          .collection('messages'),
      data: Message.fromChatMessage(m).toMap(),
    );
    return FirestoreService.to.updateDoc(
      colId: 'rooms',
      docId: room.id,
      data: {'latestMessage': Message.fromChatMessage(m).toMap()},
    );
  }

  @override
  void onInit() {
    super.onInit();
  }
}
