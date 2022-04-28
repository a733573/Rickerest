import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/utils/logger.dart';
import 'package:rickerest/app/routes/app_pages.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final FirebaseAuth auth = FirebaseAuth.instance;

  User? get currentUser => auth.currentUser;

  String? get uid => currentUser?.uid;

  @override
  void onInit() {
    super.onInit();
    auth.authStateChanges().listen((user) {
      if (user != null) {
        logger.info('Signed in!');
        Get.offAllNamed(Routes.home);
      } else {
        logger.info('Signed out!');
        Get.offAllNamed(Routes.signIn);
      }
    });
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } on Exception catch (e, s) {
      logger.warning('${e.toString()} $s');
    }
  }
}
