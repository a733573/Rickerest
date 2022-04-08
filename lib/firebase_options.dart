// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members, no_default_cases
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAYTaqbyfUP1nvivt5titBISDRxq0VtHfM',
    appId: '1:1039744153156:web:9abf51b1b3e2592128ee11',
    messagingSenderId: '1039744153156',
    projectId: 'rickerest',
    authDomain: 'rickerest.firebaseapp.com',
    databaseURL:
        'https://rickerest-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'rickerest.appspot.com',
    measurementId: 'G-NWLB0SWEP9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVHm-nVXBfAFCawF0uBpxI0JkVmDDm8Xw',
    appId: '1:1039744153156:android:36be99bbd0dff1c228ee11',
    messagingSenderId: '1039744153156',
    projectId: 'rickerest',
    databaseURL:
        'https://rickerest-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'rickerest.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdPZbjaM4CkBPmaAyMLfN8EgPBsDHT6JU',
    appId: '1:1039744153156:ios:87a6051db399b1f228ee11',
    messagingSenderId: '1039744153156',
    projectId: 'rickerest',
    databaseURL:
        'https://rickerest-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'rickerest.appspot.com',
    iosClientId:
        '1039744153156-f2826k20iogpjibkt8cc5mmmil7bcf50.apps.googleusercontent.com',
    iosBundleId: 'com.rickerest.rickerest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdPZbjaM4CkBPmaAyMLfN8EgPBsDHT6JU',
    appId: '1:1039744153156:ios:87a6051db399b1f228ee11',
    messagingSenderId: '1039744153156',
    projectId: 'rickerest',
    databaseURL:
        'https://rickerest-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'rickerest.appspot.com',
    iosClientId:
        '1039744153156-f2826k20iogpjibkt8cc5mmmil7bcf50.apps.googleusercontent.com',
    iosBundleId: 'com.rickerest.rickerest',
  );
}