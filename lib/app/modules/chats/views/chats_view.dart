import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/global/widgets/auth_gate.dart';

import '../../../global/widgets/custom_bottom_navigation_bar.dart';
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
          automaticallyImplyLeading: false,
        ),
        body: const Center(),
        bottomNavigationBar: const CustomBottomNavigationBar(
          selectedIndex: 1,
        ),
      ),
    );
  }
}
