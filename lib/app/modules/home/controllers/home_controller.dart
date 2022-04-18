import 'package:get/get.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';
import 'package:simple_logger/simple_logger.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final RxMap<String, String> currentUserData =
      {'name': '', 'avatarImageUrl': ''}.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    final Map<String, String>? data = await _getCurrentUserProfileData();
    if (data != null) {
      currentUserData.value = data;
    }
  }

  Future<void> findAccount(String email) async {
    if (AuthService.to.currentUser?.email == email) {
      Get.snackbar(
        'Error',
        'You can\'t add yourself to your friends.',
        duration: const Duration(seconds: 5),
      );
      return;
    }

    final doc = await FirestoreService.to.findAccountByEmail(email);
    if (doc != null) {
      final name = doc.data()['name'];
      return Get.defaultDialog(
        title: 'User found!',
        middleText: 'Do you want to add "$name" to your friends?',
        onConfirm: () async {
          var snackbarTitle = '';
          var snackbarMessage = '';
          await _addFriend(friendUid: doc.id).then(
            (value) {
              snackbarTitle = 'Success!';
              snackbarMessage = '"$name" was added to your friends.';
            },
          ).catchError(
            (error) {
              snackbarTitle = 'Error';
              snackbarMessage = 'Failed to add friend.';
              SimpleLogger().warning('Failed to add friend: $error');
            },
          );
          Get
            ..back()
            ..snackbar(
              snackbarTitle,
              snackbarMessage,
              duration: const Duration(seconds: 5),
            );
        },
        onCancel: () {},
      );
    } else {
      Get.snackbar(
        'User not found.',
        'No user was found.',
        duration: const Duration(seconds: 5),
      );
    }
  }

  Future<String?> _addFriend({required String friendUid}) async {
    final friendDoc = await FirestoreService.to
        .getDocByDocId(colId: 'users', docId: friendUid);
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

  Future<Map<String, String>?> _getCurrentUserProfileData() async {
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
}
