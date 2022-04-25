import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';
import 'package:rickerest/app/data/services/storage_service.dart';

class EditProfileController extends GetxController {
  static EditProfileController get to => Get.find();

  final Rx<Uint8List> _avatarImageByte = Uint8List(0).obs;

  Uint8List get avatarImageByte => _avatarImageByte.value;

  set avatarImageByte(Uint8List data) => _avatarImageByte.value = data;

  final textEditingController =
      TextEditingController(text: FirestoreService.to.currentUser.name);

  final RxBool _isChanged = false.obs;

  bool get isChanged => _isChanged.value;

  set isChanged(bool value) => _isChanged.value = value;

  final RxBool _textIsEmpty = false.obs;

  bool get textIsEmpty => _textIsEmpty.value;

  set textIsEmpty(bool value) => _textIsEmpty.value = value;

  final RxString _errorText = ''.obs;

  String get errorText => _errorText.value;

  set errorText(String value) => _errorText.value = value;

  Future<void> save() async {
    final Map<String, dynamic> data = {};
    if (textEditingController.value.text !=
        FirestoreService.to.currentUser.name) {
      data['name'] = textEditingController.value.text;
    }
    if (avatarImageByte.isNotEmpty) {
      final url = await StorageService.to.uploadAvatarImage(avatarImageByte);
      data['avatarImageUrl'] = url;
    }
    await FirestoreService.to
        .updateDoc(colId: 'users', docId: AuthService.to.uid!, data: data);
    Get.back();
  }

  void validate(String value) {
    textIsEmpty = value.isEmpty;
    if (textIsEmpty) {
      errorText = 'textIsEmpty'.tr;
    } else {
      errorText = '';
    }
  }
}
