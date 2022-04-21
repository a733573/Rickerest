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
      TextEditingController(text: FirestoreService.to.currentUserModel!.name);

  final RxBool _isChanged = false.obs;

  bool get isChanged => _isChanged.value;

  set isChanged(bool value) => _isChanged.value = value;

  Future<void> save() async {
    final Map<String, dynamic> data = {};
    data['name'] = textEditingController.value.text;
    if (avatarImageByte.isNotEmpty) {
      final url = await StorageService.to.uploadAvatarImage(avatarImageByte);
      data['avatarImageUrl'] = url;
    } else {
      data['avatarImageUrl'] =
          FirestoreService.to.currentUserModel!.avatarImageUrl;
    }

    final entries = [MapEntry(AuthService.to.uid!, data)];
    for (final friendUserModel
        in FirestoreService.to.currentUserModel!.friendsList) {
      final entry = MapEntry(
        friendUserModel.uid,
        {'friends.${AuthService.to.uid}': data},
      );
      entries.add(entry);
    }
    await FirestoreService.to.batchUpdate(colId: 'users', entries: entries);
    Get.back();
  }
}
