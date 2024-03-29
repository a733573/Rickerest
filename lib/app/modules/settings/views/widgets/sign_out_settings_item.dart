import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nil/nil.dart';
import 'package:rickerest/app/data/services/auth_service.dart';

class SignOutSettingsItem extends StatelessWidget {
  const SignOutSettingsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return S2Tile(
      title: Text('signOut'.tr),
      value: nil,
      onTap: () => _signOutDialog(),
      leading: const Icon(Icons.logout),
    );
  }

  void _signOutDialog() {
    Get.defaultDialog(
      title: 'signOut'.tr,
      middleText: 'Do you want to sign out?',
      onConfirm: () {
        AuthService.to.signOut();
      },
      onCancel: () {},
    );
  }
}
