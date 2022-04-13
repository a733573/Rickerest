import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/modules/settings/views/widgets/licenses_settings_item.dart';
import 'package:rickerest/app/modules/settings/views/widgets/sign_out_settings_item.dart';
import 'package:rickerest/app/modules/settings/views/widgets/theme_settings_item.dart';

import '../../../global/widgets/auth_gate.dart';
import '../../../global/widgets/custom_bottom_navigation_bar.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthGate(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
          ),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: SizedBox(
            width: 600,
            child: Column(
              children: const [
                Divider(),
                ThemeSettingsItem(),
                Divider(),
                LicensesSettingsItem(),
                Divider(),
                SignOutSettingsItem(),
                Divider(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 2),
      ),
    );
  }
}
