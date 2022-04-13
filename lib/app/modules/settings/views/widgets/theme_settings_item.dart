import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:rickerest/app/data/model/settings_model.dart';

import '../../controllers/settings_controller.dart';

class ThemeSettingsItem extends StatelessWidget {
  const ThemeSettingsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartSelect.single(
      title: 'Theme',
      choiceItems: [
        S2Choice(value: ThemeModeIndex.dark, title: 'Dark'),
        S2Choice(value: ThemeModeIndex.light, title: 'Light'),
        S2Choice(value: ThemeModeIndex.system, title: 'System default'),
      ],
      selectedValue: SettingsController.to.settingsModel.currentThemeModeIndex,
      onChange: (choiceItem) => SettingsController
          .to.settingsModel.currentThemeModeIndex = choiceItem.value! as int,
      modalType: S2ModalType.popupDialog,
      modalStyle: S2ModalStyle(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      tileBuilder: (context, state) {
        return S2Tile.fromState(
          state,
          leading: const Icon(Icons.format_paint),
        );
      },
    );
  }
}
