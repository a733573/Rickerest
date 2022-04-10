import 'package:get/get.dart';
import 'package:rickerest/app/global/controllers/firestore_controller.dart';

import '../../../global/controllers/auth_controller.dart';
import '../../../global/controllers/user_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<HomeController>(() => HomeController())
      ..lazyPut<FirestoreController>(() => FirestoreController())
      ..lazyPut<AuthController>(() => AuthController())
      ..lazyPut<UserController>(() => UserController());
  }
}
