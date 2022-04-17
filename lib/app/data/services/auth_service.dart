import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:simple_logger/simple_logger.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final FirebaseAuth auth = FirebaseAuth.instance;

  User? get currentUser => auth.currentUser;

  String get uid => currentUser?.uid ?? '';

  Future<void> signOut() async {
    try {
      return auth.signOut();
    } on Exception catch (e, s) {
      SimpleLogger().warning('${e.toString()} $s');
    }
  }
}
