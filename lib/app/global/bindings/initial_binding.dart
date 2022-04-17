import 'package:get/get.dart';

import '../../data/services/auth_service.dart';
import '../../data/services/firestore_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..put(AuthService())
      ..put(FirestoreService());
  }
}
