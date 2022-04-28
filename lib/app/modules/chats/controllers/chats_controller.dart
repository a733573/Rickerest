import 'package:get/get.dart';
import 'package:rickerest/app/data/models/room.dart';

class ChatsController extends GetxController {
  static ChatsController get to => Get.find();

  String latestMessageText(Room room) {
    // final sentBy = room.latestMessage!.sentBy;
    final text = _limitText(room.latestMessage!.text);
    return text;
  }

  String _limitText(String text) {
    return text.length > 70 ? '${text.substring(0, 70)}...' : text;
  }

  String latestMessageCreatedAt(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inHours < 24) {
      return '${d.hour}:${d.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'yesterday';
    } else {
      return '${d.month}/${d.day}';
    }
  }
}
