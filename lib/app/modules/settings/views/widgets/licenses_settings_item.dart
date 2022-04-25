import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nil/nil.dart';

class LicensesSettingsItem extends StatelessWidget {
  const LicensesSettingsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return S2Tile(
      title: Text('showLicenses'.tr),
      value: nil,
      onTap: () => showLicensePage(context: context),
      leading: const Icon(Icons.text_snippet),
    );
  }
}
