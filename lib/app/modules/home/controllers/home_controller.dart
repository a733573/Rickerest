import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  // final RxMap<String, String> currentUserData =
  //     {'name': '', 'avatarImageUrl': ''}.obs;

  // @override
  // Future<void> onInit() async {
  //   super.onInit();

  // final Map<String, String>? data = await _getCurrentUserProfileData();
  // if (data != null) {
  //   currentUserData.value = data;
  // }
  // }

  // Future<Map<String, String>?> _getCurrentUserProfileData() async {
  //   final documentSnapshot = await FirestoreService.to
  //       .getDocByDocId(colId: 'users', docId: AuthService.to.uid);
  //   final data = documentSnapshot.data();
  //   return data != null
  //       ? {
  //           'name': data['name'] as String? ?? '',
  //           'avatarImageUrl': data['avatarImageUrl'] as String? ?? '',
  //         }
  //       : null;
  // }
}
