import 'package:get/get.dart';

class ChatsController extends GetxController {
  static ChatsController get to => Get.find();

  String limitText(String text) {
    return text.length > 70 ? '${text.substring(0, 70)}...' : text;
  }

  String relativeTime(DateTime d) {
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
