import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/global/controllers/auth_controller.dart';
import 'package:rickerest/app/routes/app_pages.dart';

class SignOutIconButton extends StatelessWidget {
  const SignOutIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.defaultDialog(
          title: 'Alert',
          content: const Text('Do you want to sign out?'),
          onCancel: () => Get.back(),
          onConfirm: () {
            AuthController.to.signOut();
            Get.offAllNamed(Routes.home);
          },
        );
      },
      icon: const Icon(Icons.logout),
    );
  }
}
