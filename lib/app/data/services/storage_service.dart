import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/utils/logger.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

import 'auth_service.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();

  final storage = FirebaseStorage.instance;
  late final Reference avatarImageRef;
  late final String defaultAvatarImageUrl;

  @override
  Future<void> onInit() async {
    super.onInit();
    avatarImageRef = storage.ref().child('images/avatar');
    defaultAvatarImageUrl =
        await avatarImageRef.child('default_avatar_image.png').getDownloadURL();
  }

  Future<String> avatarImageUrl(String uid) async {
    try {
      return avatarImageRef.child('$uid.png').getDownloadURL();
    } on Exception catch (e) {
      logger.warning(e);
      return defaultAvatarImageUrl;
    }
  }

  Future<void> uploadAvatarImage(Uint8List data) async {
    try {
      final imageRef =
          avatarImageRef.child('avatar_image_${AuthService.to.uid!}.png');
      await imageRef.putData(data);
      logger.info('Uploaded an avatar image.');

      final avatarImageUrl = await imageRef.getDownloadURL();
      await FirestoreService.to.updateDoc(
        colId: 'users',
        docId: AuthService.to.uid!,
        data: {'avatarImageUrl': avatarImageUrl},
      );

      for (final friendUserModel
          in FirestoreService.to.currentUserModel!.friendsList) {
        await FirestoreService.to.updateDoc(
          colId: 'users',
          docId: friendUserModel.uid,
          data: {
            'friends.${AuthService.to.uid}.avatarImageUrl': avatarImageUrl
          },
        );
      }
    } on FirebaseException catch (e) {
      logger.warning(e);
    }
  }
}
