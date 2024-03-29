import 'package:get/get.dart';
import 'package:rickerest/app/core/utils/logger.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

class SettingsController extends GetxController {
  static SettingsController get to => Get.find();

  Future<void> deleteAccount() async {
    try {
      // user.reauthenticateWithCredential(credential);
      await AuthService.to.currentUser?.delete();
      return FirestoreService.to
          .deleteDoc(colId: 'users', docId: AuthService.to.uid!);
    } on Exception catch (e, s) {
      logger.warning('${e.toString()} $s');
    }
  }
}
