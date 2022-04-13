import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nil/nil.dart';
import 'package:rickerest/app/global/controllers/auth_controller.dart';

import '../../../../routes/app_pages.dart';

class SignOutSettingsItem extends StatelessWidget {
  const SignOutSettingsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return S2Tile(
      title: const Text('Sign out'),
      value: nil,
      onTap: () => _signOut(),
      leading: const Icon(Icons.logout),
    );
  }

  void _signOut() {
    Get.defaultDialog(
      title: 'Sign out',
      middleText: 'Do you want to sign out?',
      onConfirm: () {
        AuthController.to.signOut();
        Get.offAllNamed(Routes.home);
      },
      onCancel: () => Get.back(),
    );
  }
}
