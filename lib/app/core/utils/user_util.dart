import 'package:flutter/cupertino.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

import '../../data/services/auth_service.dart';

Future<Map<String, String>?> get getCurrentUserProfileData async {
  final documentSnapshot = await FirestoreService.to
      .getDocByDocId(colId: 'users', docId: AuthService.to.uid);
  final data = documentSnapshot.data();
  return data != null
      ? {
          'name': data['name'] as String? ?? '',
          'avatarImageUrl': data['avatarImageUrl'] as String? ?? '',
        }
      : null;
}

Future<void> createUser({
  required String uid,
  required String name,
  required String email,
}) {
  return FirestoreService.to.setDoc(
    colId: 'users',
    docId: AuthService.to.uid,
    data: {
      'name': name,
      'email': email,
    },
  );
}

Future<void> deleteAccount() async {
  try {
    // user.reauthenticateWithCredential(credential);
    await AuthService.to.currentUser?.delete();
    return FirestoreService.to
        .deleteDoc(colId: 'users', docId: AuthService.to.uid);
  } on Exception catch (e, s) {
    debugPrint('${e.toString()} $s');
  }
}

Future<void> addFriend({required String friendUid}) async {
  final friendDoc =
      await FirestoreService.to.getDocByDocId(colId: 'users', docId: friendUid);
  final friendData = {
    'friends.$friendUid': {
      'name': friendDoc.data()?['name'],
      'avatarImageUrl': friendDoc.data()?['avatarImageUrl']
    }
  };
  await FirestoreService.to.updateDoc(
    colId: 'users',
    docId: AuthService.to.uid,
    data: friendData,
  );

  final userDoc = await FirestoreService.to.getDocByDocId(
    colId: 'users',
    docId: AuthService.to.uid,
  );
  final userData = {
    'friends.$AuthService.to.uid': {
      'name': userDoc.data()?['name'],
      'avatarImageUrl': userDoc.data()?['avatarImageUrl']
    }
  };
  return FirestoreService.to.updateDoc(
    colId: 'users',
    docId: friendUid,
    data: userData,
  );
}
