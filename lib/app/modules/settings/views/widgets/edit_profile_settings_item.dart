import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nil/nil.dart';
import 'package:rickerest/app/routes/app_pages.dart';

class EditProfileSettingsItem extends StatelessWidget {
  const EditProfileSettingsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return S2Tile(
      title: Text('editProfile'.tr),
      value: nil,
      onTap: () => Get.toNamed(Routes.editProfile),
      leading: const Icon(Icons.manage_accounts),
    );
  }
}
