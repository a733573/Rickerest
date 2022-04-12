import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/widgets/auth_gate.dart';
import '../../../global/widgets/custom_bottom_navigation_bar.dart';
import '../controllers/settings_controller.dart';
import 'widgets/custom_settings_list.dart';

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
        body: const CustomSettingsList(),
        bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 2),
      ),
    );
  }
}
