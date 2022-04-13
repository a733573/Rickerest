import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/dropdown/gf_dropdown.dart';
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
          border: BorderSide(
            width: 1,
            color: SettingsController.to.currentThemeData.highlightColor,
          ),
          dropdownButtonColor:
              SettingsController.to.currentThemeData.backgroundColor,
          value: SettingsController.to.settingsModel.currentThemeModeIndex,
          onChanged: (value) => SettingsController
              .to.settingsModel.currentThemeModeIndex = value! as int,
          items: const [
            DropdownMenuItem(
              value: ThemeModeIndex.dark,
              child: Text('Dark'),
            ),
            DropdownMenuItem(
              value: ThemeModeIndex.light,
              child: Text('Light'),
            ),
            DropdownMenuItem(
              value: ThemeModeIndex.system,
              child: Text('System default'),
            ),
          ],
        );
      }),
    );
  }
}
