import 'package:awesome_select/awesome_select.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';

class ThemeSettingsItem extends StatelessWidget {
  const ThemeSettingsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartSelect.single(
      title: 'Theme',
      choiceItems: [
        S2Choice(value: ThemeMode.dark, title: 'Dark'),
        S2Choice(value: ThemeMode.light, title: 'Light'),
        S2Choice(value: ThemeMode.system, title: 'System default'),
      ],
      selectedValue: EasyDynamicTheme.of(context).themeMode!,
      onChange: (choiceItem) => _changeTheme(
        context: context,
        themeMode: choiceItem.value! as ThemeMode,
      ),
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

  void _changeTheme({
    required BuildContext context,
    required ThemeMode themeMode,
  }) {
    switch (themeMode) {
      case ThemeMode.dark:
        EasyDynamicTheme.of(context).changeTheme(dark: true);
        break;
      case ThemeMode.light:
        EasyDynamicTheme.of(context).changeTheme(dark: false);
        break;
      case ThemeMode.system:
        EasyDynamicTheme.of(context).changeTheme(dynamic: true);
        break;
    }
  }
}
