import 'package:get/get.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';
import 'package:rickerest/app/data/services/storage_service.dart';

import '../../data/services/auth_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put(AuthService())
      ..put(FirestoreService())
      ..lazyPut(() => StorageService());
  }
}
