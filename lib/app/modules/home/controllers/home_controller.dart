import 'package:get/get.dart';
// import 'package:rickerest/app/core/utils/logger.dart';
// import 'package:rickerest/app/data/models/current_user.dart';
// import 'package:rickerest/app/data/services/auth_service.dart';
// import 'package:rickerest/app/data/services/firestore_service.dart';

// import '../../../data/models/user.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

//   @override
//   void onInit() {
//     super.onInit();
//     FirestoreService.to.db
//         .collection('users')
//         .doc(AuthService.to.uid)
//         .snapshots()
//         .listen((documentSnapshot) {
//       FirestoreService.to.currentUser =
//           CurrentUser.fromMap(documentSnapshot.data()!);
//     });
//     FirestoreService.to.db
//         .collection('users')
//         .where(
//           'uid',
//           whereIn: FirestoreService.to.currentUser.friends.isEmpty
//               ? ['']
//               : FirestoreService.to.currentUser.friends,
//         )
//         .orderBy('name')
//         .snapshots()
//         .listen((querySnapshot) {
//       FirestoreService.to.friendUsers.value = querySnapshot.docs.map((doc) {
//         logger.info('friends lister: ${doc.data()}');
//         return User.fromMap(doc.data());
//       }).toList();
//     });
//   }
}
