import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    // ..lazyPut<FirestoreController>(() => FirestoreController())
    // ..lazyPut<AuthController>(() => AuthController())
    // ..lazyPut<UserController>(() => UserController());
  }
}
