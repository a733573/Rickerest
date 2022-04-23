import 'package:email_validator/email_validator.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/utils/logger.dart';
import 'package:rickerest/app/data/models/friend_user.dart';
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
    if (AuthService.to.currentUser?.email == textEditingController.value.text) {
      _errorText.value = 'You can\'t add yourself to your friends.';
    }
    if (_errorText.value.isNotEmpty) {
      return;
    }

    final doc = await FirestoreService.to
        .findAccountByEmail(textEditingController.value.text);
    if (doc != null) {
      textEditingController.clear();
      if (FirestoreService.to.currentUser?.friendsList
              .firstWhereOrNull((e) => e.uid == doc.id) !=
          null) {
        _errorText.value = '"${doc.data()['name']}" is already your friend.';
        return;
      }
      final friendUser = FriendUser(
        uid: doc.id,
        data: {
          'name': doc.data()['name'],
          'avatarImageUrl': doc.data()['avatarImageUrl']
        },
      );
      return Get.defaultDialog(
        title: 'User found!',
        middleText: 'Do you want to add "${friendUser.name}" to your friends?',
        onConfirm: () async {
          var snackbarTitle = '';
          var snackbarMessage = '';
          await _addFriend(friendUser).then(
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
      _errorText.value = 'User not found.';
    }
  }

  Future<void> _addFriend(FriendUser friendUser) {
    final currentUser = FirestoreService.to.currentUser;
    final currentUserEntry = MapEntry(AuthService.to.uid!, {
      'friends.${friendUser.uid}': {
        'name': friendUser.name,
        'avatarImageUrl': friendUser.avatarImageUrl
      }
    });
    final friendUserEntry = MapEntry(friendUser.uid, {
      'friends.${AuthService.to.uid!}': {
        'name': currentUser!.name,
        'avatarImageUrl': currentUser.avatarImageUrl
      }
    });
    return FirestoreService.to.batchUpdate(
      colId: 'users',
      entries: [currentUserEntry, friendUserEntry],
    );
  }
}
