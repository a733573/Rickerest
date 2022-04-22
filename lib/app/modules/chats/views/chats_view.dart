import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/widgets/custom_bottom_navigation_bar.dart';
import '../controllers/chats_controller.dart';

class ChatsView extends GetView<ChatsController> {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        automaticallyImplyLeading: false,
      ),
      body: Scaffold(
        appBar: AppBar(
          title: const Text('Basic example'),
        ),
        body: DashChat(
          currentUser: controller.user,
          onSend: (ChatMessage m) {
            controller.messages.insert(0, m);
          },
          messages: controller.messages,
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        selectedIndex: 1,
      ),
    );
  }
}
