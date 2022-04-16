import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/global/controllers/user_controller.dart';

import '../../../../global/controllers/firestore_controller.dart';

class FindAccountTextField extends StatelessWidget {
  const FindAccountTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: _findAccount,
      decoration:
          const InputDecoration(labelText: 'Find you friend by email...'),
    );
  }

  Future<void> _findAccount(String email) async {
    if (UserController.to.user?.email == email) {
      return Get.defaultDialog(
        title: 'Error',
        middleText: 'You can\'t add yourself to your friends list.',
      );
    }

    final doc = await FirestoreController.to.findAccountByEmail(email);
    if (doc != null) {
      final name = doc.data()['name'];
      return Get.defaultDialog(
        title: 'User found!',
        middleText: 'Do you want to add "$name" to your friends list?',
        onConfirm: () async {
          var snackbarTitle = '';
          var snackbarMessage = '';
          await UserController.to.addFriend(friendUid: doc.id).then(
            (value) {
              snackbarTitle = 'Success!';
              snackbarMessage = '"$name" was added to your friends list.';
            },
          ).catchError(
            (error) {
              snackbarTitle = 'Error';
              snackbarMessage = 'Failed to add friend.';
              debugPrint('Failed to add friend: $error');
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
      return Get.defaultDialog(
        title: 'User not found.',
        middleText: 'No user was found.',
        onConfirm: () {},
      );
    }
  }
}
