import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/utils/logger.dart';
import 'package:rickerest/app/data/models/friend_user_model.dart';
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
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
      return;
    }

    final doc = await FirestoreService.to
        .findAccountByEmail(textEditingController.value.text);
    if (doc != null) {
      textEditingController.clear();
      final friendUserModel = FriendUserModel(
        uid: doc.id,
        data: {
          'name': doc.data()['name'],
          'avatarImageUrl': doc.data()['avatarImageUrl']
        },
      );
      return Get.defaultDialog(
        title: 'User found!',
        middleText:
            'Do you want to add "${friendUserModel.name}" to your friends?',
        onConfirm: () async {
          var snackbarTitle = '';
          var snackbarMessage = '';
          await _addFriend(friendUserModel).then(
            (_) {
              snackbarTitle = 'Success!';
              snackbarMessage =
                  '"${friendUserModel.name}" was added to your friends.';
            },
          ).catchError(
            (error) {
              snackbarTitle = 'Error';
              snackbarMessage = 'Failed to add friend.';
              logger.warning('Failed to add friend: $error');
            },
          );
          Get
            ..back()
            ..snackbar(
              snackbarTitle,
              snackbarMessage,
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 5),
            );
        },
        onCancel: () {},
      );
    } else {
      // Get.snackbar(
      //   'User not found.',
      //   'No user was found.',
      //   duration: const Duration(seconds: 5),
      // );
      _errorText.value = 'User not found.';
    }
  }

  Future<void> _addFriend(FriendUserModel friendUserModel) {
    final currentUserModel = FirestoreService.to.currentUserModel;
    final currentUserEntry = MapEntry(AuthService.to.uid!, {
      'friends.${friendUserModel.uid}': {
        'name': friendUserModel.name,
        'avatarImageUrl': friendUserModel.avatarImageUrl
      }
    });
    final friendUserEntry = MapEntry(friendUserModel.uid, {
      'friends.${AuthService.to.uid!}': {
        'name': currentUserModel!.name,
        'avatarImageUrl': currentUserModel.avatarImageUrl
      }
    });
    return FirestoreService.to
        .batchUpdate(colId: 'users', data: [currentUserEntry, friendUserEntry]);
  }
}
