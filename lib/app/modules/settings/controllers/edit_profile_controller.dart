import 'package:get/get.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

class EditProfileController extends GetxController {
  static EditProfileController get to => Get.find();

  final RxString _avatarImageUrl =
      FirestoreService.to.currentUserModel!.avatarImageUrl.obs;

  String get avatarImageUrl => _avatarImageUrl.value;

  set avatarImageUrl(String url) => _avatarImageUrl.value = url;
}
