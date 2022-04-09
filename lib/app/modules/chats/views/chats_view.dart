import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/global/widgets/auth_gate.dart';

import '../../../global/widgets/sign_out_icon_button.dart';
import '../controllers/chats_controller.dart';

class ChatsView extends GetView<ChatsController> {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthGate(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
          actions: const [
            SignOutIconButton(),
          ],
          elevation: 0,
          backgroundColor: Colors.brown.withOpacity(0.5),
          automaticallyImplyLeading: false,
        ),
        body: const Center(
          child: Text(
            'ChatsView is working',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
