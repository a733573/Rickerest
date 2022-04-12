import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
import 'package:rickerest/app/core/theme/app_theme.dart';
import 'package:rickerest/app/data/model/settings_model.dart';
import 'package:rickerest/app/modules/settings/controllers/settings_controller.dart';

class SettingsThemeDropdown extends StatelessWidget {
  const SettingsThemeDropdown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Obx(() {
        return GFDropdown(
          padding: const EdgeInsets.all(15),
          borderRadius: BorderRadius.circular(5),
          border:
              BorderSide(width: 1, color: AppTheme.current().highlightColor),
          dropdownButtonColor: AppTheme.current().backgroundColor,
          value: SettingsController.to.settingsModel.themeModeIndex,
          onChanged: (value) => SettingsController
              .to.settingsModel.themeModeIndex = value! as int,
          items: [
            DropdownMenuItem(
              value: ThemeMode.dark.toInt(),
              child: const Text('Dark'),
            ),
            DropdownMenuItem(
              value: ThemeMode.light.toInt(),
              child: const Text('Light'),
            ),
            DropdownMenuItem(
              value: ThemeMode.system.toInt(),
              child: const Text('System default'),
            ),
          ],
        );
      }),
    );
  }
}
