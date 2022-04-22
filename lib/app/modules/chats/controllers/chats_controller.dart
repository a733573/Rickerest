import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController {
  static ChatsController get to => Get.find();

  ChatUser user = ChatUser(
    id: '1',
    firstName: 'Charles',
    lastName: 'Leclerc',
  );

  late List<ChatMessage> messages;

  @override
  void onInit() {
    super.onInit();
    messages = [
      ChatMessage(
        text: 'Hey!',
        user: user,
        createdAt: DateTime.now(),
      ),
    ];
  }
}
