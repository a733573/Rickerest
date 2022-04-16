import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nil/nil.dart';
import 'package:rickerest/app/global/controllers/user_controller.dart';

import '../../../../routes/app_pages.dart';

class DeleteAccountSettingsItem extends StatelessWidget {
  const DeleteAccountSettingsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return S2Tile(
      title: const Text('Delete your account'),
      value: nil,
      onTap: () => _deleteAccountDialog(),
      leading: const Icon(Icons.delete),
    );
  }

  void _deleteAccountDialog() {
    Get.defaultDialog(
      title: 'Delete your account',
      middleText: 'Do you want to delete your account?',
      onConfirm: () async {
        await UserController.to.deleteAccount();
        return Get.offAllNamed(Routes.home);
      },
      onCancel: () {},
    );
  }
}
