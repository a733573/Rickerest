import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/utils/logger.dart';
import 'package:rickerest/app/data/models/user.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

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
    _errorText.value = (_isNotSubmitted || EmailValidator.validate(value))
        ? ''
        : 'invalidEmail'.tr;
  }

  Future<void> findAccount() async {
    _isNotSubmitted = false;
    validateText(textEditingController.value.text);
    if (AuthService.to.currentUser?.email == textEditingController.value.text) {
      _errorText.value = 'youCan\'tAddYourself'.tr;
    }
    if (_errorText.value.isNotEmpty) {
      return;
    }

    final doc = await FirestoreService.to
        .findAccountByEmail(textEditingController.value.text);
    if (doc != null) {
      final friendUser = User.fromMap(doc.data());
      textEditingController.clear();
      if (FirestoreService.to.currentUser.friends.contains(friendUser.uid)) {
        _errorText.value =
            '"${doc.data()['name']}" ${'isAlreadyYourFriend'.tr}';
        return;
      }
      return Get.defaultDialog(
        title: 'User found!',
        middleText: 'Do you want to add "${friendUser.name}" to your friends?',
        onConfirm: () async {
          var snackbarTitle = '';
          var snackbarMessage = '';
          await _addFriend(friendUser.uid).then(
            (_) {
              snackbarTitle = 'Success!';
              snackbarMessage =
                  '"${friendUser.name}" was added to your friends.';
            },
          ).catchError(
            (error) {
              snackbarTitle = 'Error';
              snackbarMessage = 'Failed to add friend.';
              logger.warning('Failed to add friend: $error');
            },
          );
          _isNotSubmitted = true;
          Get
            ..back()
            ..back()
            ..snackbar(
              snackbarTitle,
              snackbarMessage,
            );
        },
        onCancel: () {},
      );
    } else {
      _errorText.value = 'User not found.';
    }
  }

  Future<void> _addFriend(String friendUid) {
    final currentUserEntry = MapEntry(AuthService.to.uid!, {
      'friends': FieldValue.arrayUnion([friendUid])
    });
    final friendUserEntry = MapEntry(friendUid, {
      'friends': FieldValue.arrayUnion([AuthService.to.uid!])
    });
    return FirestoreService.to.batchUpdate(
      colId: 'users',
      entries: [currentUserEntry, friendUserEntry],
    );
  }
}
