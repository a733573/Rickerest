import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/utils/logger.dart';

import 'auth_service.dart';

const defaultAvatarImageUrl =
    'https://firebasestorage.googleapis.com/v0/b/rickerest.appspot.com/o/images%2Favatar%2Fdefault_avatar_image.png?alt=media&token=ca131581-df0c-42fb-9646-95afb3183f84';

class StorageService extends GetxService {
  static StorageService get to => Get.find();

  final storage = FirebaseStorage.instance;
  late final Reference avatarImageRef;

  @override
  void onInit() {
    super.onInit();
    avatarImageRef = storage.ref().child('images/avatar');
  }

  Future<String> uploadAvatarImage(Uint8List imageBytes) async {
    final imageRef =
        avatarImageRef.child('avatarImage_${AuthService.to.uid!}.png');
    await imageRef.putData(imageBytes);
    final url = await imageRef.getDownloadURL();
    logger.info('Uploaded an avatar image.: $url');
    return url;
  }
}
