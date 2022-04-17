import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final FirebaseAuth auth = FirebaseAuth.instance;

  User? get currentUser => auth.currentUser;

  String get uid => currentUser?.uid ?? '';

  Future<void> signOut() async {
    try {
      return auth.signOut();
    } on Exception catch (e, s) {
      debugPrint('${e.toString()} $s');
    }
  }
}
