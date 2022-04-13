import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rickerest/app/modules/settings/controllers/settings_controller.dart';
import 'package:rickerest/firebase_options.dart';

import 'app/core/theme/app_theme.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  Get.put(SettingsController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rickerest',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode
          .values[SettingsController.to.settingsModel.currentThemeModeIndex],
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      unknownRoute: AppPages.notFound,
    );
  }
}
