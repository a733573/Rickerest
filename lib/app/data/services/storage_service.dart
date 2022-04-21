import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/utils/logger.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

import 'auth_service.dart';

const defaultAvatarImageUrl =
    'https://firebasestorage.googleapis.com/v0/b/rickerest.appspot.com/o/images%2Favatar%2Fdefault_avatar_image.png?alt=media&token=ca131581-df0c-42fb-9646-95afb3183f84';

class StorageService extends GetxService {
  static StorageService get to => Get.find();

  final storage = FirebaseStorage.instance;
  late final Reference avatarImageRef;

  @override
  Future<void> onInit() async {
    super.onInit();
    avatarImageRef = storage.ref().child('images/avatar');
    // defaultAvatarImageUrl =
    // await avatarImageRef.child('default_avatar_image.png').getDownloadURL();
  }

  // Future<String> avatarImageUrl(String uid) async {
  //   try {
  //     return avatarImageRef.child('$uid.png').getDownloadURL();
  //   } on Exception catch (e) {
  //     logger.warning(e);
  //     return defaultAvatarImageUrl;
  //   }
  // }

  Future<String> uploadAvatarImage(Uint8List imageBytes) async {
    final imageRef =
        avatarImageRef.child('avatar_image_${AuthService.to.uid!}.png');
    await imageRef.putData(imageBytes);
    logger.info('Uploaded an avatar image.');

    final avatarImageUrl = await imageRef.getDownloadURL();
    final data = [
      MapEntry(AuthService.to.uid!, {'avatarImageUrl': avatarImageUrl})
    ];
    for (final friendUserModel
        in FirestoreService.to.currentUserModel!.friendsList) {
      final entry = MapEntry(
        friendUserModel.uid,
        {'friends.${AuthService.to.uid}.avatarImageUrl': avatarImageUrl},
      );
      data.add(entry);
    }
    await FirestoreService.to.batchUpdate(colId: 'users', data: data);
    return avatarImageUrl;
  }
}
