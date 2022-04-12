import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/modules/settings/controllers/settings_controller.dart';
import 'package:rickerest/app/routes/app_pages.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../../global/controllers/auth_controller.dart';

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
              value: Obx(
                () => Text(
                  themeModeIndexToString(
                    SettingsController.to.settingsModel.themeModeIndex,
                  ),
                ),
              ),
              leading: const Icon(Icons.format_paint),
              onPressed: (_) => Get.toNamed(Routes.settingsTheme),
            ),
            SettingsTile(
              title: const Text('Sign out'),
              leading: const Icon(Icons.logout),
              onPressed: (_) => signOut(),
            )
          ],
        ),
      ],
    );
  }

  String themeModeIndexToString(int index) {
    if (ThemeMode.values[index] == ThemeMode.light) {
      return 'Light';
    }
    if (ThemeMode.values[index] == ThemeMode.dark) {
      return 'Dark';
    }
    return 'System default';
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
