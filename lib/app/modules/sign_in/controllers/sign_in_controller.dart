import 'package:get/get.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';
import 'package:rickerest/app/data/services/storage_service.dart';

class SignInController extends GetxController {
  static SignInController get to => Get.find();

  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
    String? avatarImageUrl,
  }) {
    return FirestoreService.to.setDoc(
      ref: FirestoreService.to.db.collection('users').doc(uid),
      data: {
        'uid': uid,
        'name': name,
        'email': email,
        'avatarImageUrl': avatarImageUrl ?? defaultAvatarImageUrl,
        'friends': [],
        'rooms': [],
      },
    );
  }
}
