import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:rickerest/app/data/model/settings_model.dart';
import 'package:rickerest/app/modules/settings/controllers/settings_controller.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsThemeView extends StatelessWidget {
  const SettingsThemeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme')),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: const Text('Light'),
                leading: const Icon(Icons.wb_sunny),
                trailing: Obx(() => trailingWidget(ThemeMode.light.toInt())),
                onPressed: (BuildContext context) {
                  changeTheme(ThemeMode.light.toInt());
                },
              ),
              SettingsTile(
                title: const Text('Dark'),
                leading: const Icon(Icons.dark_mode),
                trailing: Obx(() => trailingWidget(ThemeMode.dark.toInt())),
                onPressed: (BuildContext context) {
                  changeTheme(ThemeMode.dark.toInt());
                },
              ),
              SettingsTile(
                title: const Text('System default'),
                leading: const Icon(Icons.settings),
                trailing: Obx(() => trailingWidget(ThemeMode.system.toInt())),
                onPressed: (BuildContext context) {
                  changeTheme(ThemeMode.system.toInt());
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget trailingWidget(int value) {
    return (SettingsController.to.settingsModel.themeModeIndex == value)
        ? const Icon(Icons.check)
        : const Icon(null);
  }

  void changeTheme(int value) {
    SettingsController.to.settingsModel.setThemeModeIndex(value);
  }
}
