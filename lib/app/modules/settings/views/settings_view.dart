import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/modules/settings/views/widgets/delete_account_settings_item.dart';
import 'package:rickerest/app/modules/settings/views/widgets/edit_profile_settings_item.dart';
import 'package:rickerest/app/modules/settings/views/widgets/licenses_settings_item.dart';
import 'package:rickerest/app/modules/settings/views/widgets/sign_out_settings_item.dart';
import 'package:rickerest/app/modules/settings/views/widgets/theme_settings_item.dart';

import '../../../global/widgets/custom_bottom_navigation_bar.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'settings'.tr,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('general'.tr),
            ),
            const ThemeSettingsItem(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('account'.tr),
            ),
            const EditProfileSettingsItem(),
            const SignOutSettingsItem(),
            const DeleteAccountSettingsItem(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text('about'.tr),
            ),
            const LicensesSettingsItem(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 2),
    );
  }
}
