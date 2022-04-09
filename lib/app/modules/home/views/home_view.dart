import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/widgets/sign_out_icon_button.dart';
import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: const [
          SignOutIconButton(),
        ],
        elevation: 0,
        backgroundColor: Colors.brown.withOpacity(0.5),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User: ${FirebaseAuth.instance.currentUser?.email}',
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Get.toNamed(Routes.chats),
              child: const Text(
                'chats page',
                style: TextStyle(fontSize: 30),
              ),
            )
          ],
        ),
      ),
    );
  }
}
