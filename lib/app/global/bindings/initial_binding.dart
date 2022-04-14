import 'package:get/get.dart';
import 'package:rickerest/app/global/controllers/firestore_controller.dart';
import 'package:rickerest/app/global/controllers/user_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put<FirestoreController>(FirestoreController())
      ..put<UserController>(UserController());
  }
}
