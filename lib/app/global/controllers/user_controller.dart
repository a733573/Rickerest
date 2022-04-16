import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/global/controllers/firestore_controller.dart';

class UserController extends GetxController {
  static UserController get to => Get.find();

  final FirebaseAuth auth = FirebaseAuth.instance;

  final User? user = FirebaseAuth.instance.currentUser;

  String get uid => user?.uid ?? '';

  // Future<Map<String, dynamic>> get getCurrentUserData {}

  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
  }) {
    return FirestoreController.to.setDoc(
      colId: 'users',
      docId: uid,
      data: {
        'name': name,
        'email': email,
      },
    );
  }

  Future<void> deleteAccount() async {
    try {
      // user.reauthenticateWithCredential(credential);
      await user?.delete();
      return FirestoreController.to.deleteDoc(colId: 'users', docId: uid);
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

  Future<void> addFriend({required String friendUid}) async {
    final friendDoc = await FirestoreController.to
        .getDocByDocId(colId: 'users', docId: friendUid);
    final friendData = {
      'friends.$friendUid': {
        'name': friendDoc.data()?['name'],
        'avatarImageUrl': friendDoc.data()?['avatarImageUrl']
      }
    };
    await FirestoreController.to.updateDoc(
      colId: 'users',
      docId: uid,
      data: friendData,
    );

    final userDoc =
        await FirestoreController.to.getDocByDocId(colId: 'users', docId: uid);
    final userData = {
      'friends.$uid': {
        'name': userDoc.data()?['name'],
        'avatarImageUrl': userDoc.data()?['avatarImageUrl']
      }
    };
    return FirestoreController.to.updateDoc(
      colId: 'users',
      docId: friendUid,
      data: userData,
    );
  }
}
