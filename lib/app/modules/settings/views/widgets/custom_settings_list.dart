import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/modules/settings/controllers/settings_controller.dart';
import 'package:rickerest/app/modules/settings/views/widgets/settings_theme_dropdown.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../../global/controllers/auth_controller.dart';
import '../../../../routes/app_pages.dart';

class CustomSettingsList extends StatefulWidget {
  const CustomSettingsList({Key? key}) : super(key: key);

  @override
  _CustomSettingsListState createState() => _CustomSettingsListState();
}

class _CustomSettingsListState extends State<CustomSettingsList> {
  SettingsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('Common'),
          tiles: <SettingsTile>[
            SettingsTile(
              title: const Text('Theme'),
              leading: const Icon(Icons.format_paint),
              trailing: Container(
                height: 50,
                width: 170,
                margin: const EdgeInsets.all(20),
                child: const SettingsThemeDropdown(),
              ),
            ),
            SettingsTile(
              title: const Text('Licenses'),
              leading: const Icon(Icons.text_snippet),
              onPressed: (context) => showLicensePage(context: context),
            ),
            SettingsTile(
              title: const Text('Sign out'),
              leading: const Icon(Icons.logout),
              onPressed: (_) => signOut(),
            ),
          ],
        ),
      ],
    );
  }

  void signOut() {
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
