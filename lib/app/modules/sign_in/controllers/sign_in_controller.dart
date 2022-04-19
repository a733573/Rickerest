import 'package:get/get.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

class SignInController extends GetxController {
  static SignInController get to => Get.find();

  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
  }) {
    return FirestoreService.to.setDoc(
      colId: 'users',
      docId: uid,
      data: {
        'name': name,
        'email': email,
      },
    );
  }
}
