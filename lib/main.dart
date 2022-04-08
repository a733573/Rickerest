import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rickerest',
      theme: ThemeData(primarySwatch: Colors.brown),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      unknownRoute: AppPages.NOT_FOUND,
    );
  }
}

// const MaterialColor white = MaterialColor(
//   0xFFFFFFFF,
//   <int, Color>{
//     50: Color(0xFFFFFFFF),
//     100: Color(0xFFFFFFFF),
//     200: Color(0xFFFFFFFF),
//     300: Color(0xFFFFFFFF),
//     400: Color(0xFFFFFFFF),
//     500: Color(0xFFFFFFFF),
//     600: Color(0xFFFFFFFF),
//     700: Color(0xFFFFFFFF),
//     800: Color(0xFFFFFFFF),
//     900: Color(0xFFFFFFFF),
//   },
// );
