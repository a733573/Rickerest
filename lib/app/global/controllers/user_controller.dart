import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/global/controllers/firestore_controller.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final FirebaseAuth auth = FirebaseAuth.instance;

  final User user = FirebaseAuth.instance.currentUser!;

  String get uid => user.uid;

  Future<void> createUser({
    required String uid,
    required String name,
    String? avatarImageUrl,
  }) {
    return FirestoreController.to.addToFirestore(
      colId: 'users',
      docId: uid,
      data: {
        'name': name,
        'avatarImageUrl': avatarImageUrl,
        'friends': <String>[],
      },
    );
  }

  Future<void> deleteAccount() async {
    try {
      // user.reauthenticateWithCredential(credential);
      await user.delete();
      return FirestoreController.to
          .deleteFirestoreDoc(colId: 'users', docId: uid);
    } on Exception catch (e, s) {
      debugPrint('${e.toString()} $s');
    }
  }

  Future<void> signOut() async {
    try {
      return auth.signOut();
    } on Exception catch (e, s) {
      debugPrint('${e.toString()} $s');
    }
  }
}
