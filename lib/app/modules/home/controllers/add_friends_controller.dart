import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';
import 'package:simple_logger/simple_logger.dart';

class AddFriendsController extends GetxController {
  static AddFriendsController get to => Get.find();

  final textEditingController = TextEditingController();

  final RxString _errorText = ''.obs;

  String? get errorText => _errorText.value.isEmpty ? null : _errorText.value;

  final RxBool _textIsEmpty = true.obs;

  bool get textIsEmpty => _textIsEmpty.value;

  set textIsEmpty(bool value) => _textIsEmpty.value = value;

  bool _isNotSubmitted = true;

  void validateText(String value) {
    // logger.info(textEditingController.value.text);
    _errorText.value = (_isNotSubmitted || EmailValidator.validate(value))
        ? ''
        : 'Not a valid Email.';
  }

  Future<void> findAccount() async {
    _isNotSubmitted = false;
    validateText(textEditingController.value.text);
    if (_errorText.value.isNotEmpty) {
      return;
    }
    if (AuthService.to.currentUser?.email == textEditingController.value.text) {
      Get.snackbar(
        'Error',
        'You can\'t add yourself to your friends.',
        duration: const Duration(seconds: 5),
      );
      return;
    }

    final doc = await FirestoreService.to
        .findAccountByEmail(textEditingController.value.text);
    if (doc != null) {
      textEditingController.clear();
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
}
