import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/firebase_options.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    GetMaterialApp(
      title: 'Application',
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    ),
  );
}
