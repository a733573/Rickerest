import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  // @override
  // Future<void> onReady() async {
  //   super.onReady();
  //   await loadRooms();
  // }
  //
  // Future<void> loadRooms() async {
  //   FirestoreService.to.roomsCache = await FirestoreService.to.roomsQuery
  //       ?.get(const GetOptions(source: Source.serverAndCache));
  //   FirestoreService.to.rooms = FirestoreService.to.roomsCache?.docs
  //           .map((doc) => Room.fromJson(doc.data()! as JsonMap))
  //           .toList() ??
  //       [];
  //   logger.info(
  //     'roomsCache: isFromCache='
  //     '${FirestoreService.to.roomsCache?.metadata.isFromCache}',
  //   );
  // }
}
