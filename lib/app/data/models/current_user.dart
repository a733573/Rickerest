import 'package:rickerest/app/data/models/user.dart';

import '../services/firestore_service.dart';

class CurrentUser extends User {
  CurrentUser({
    required String uid,
    required String name,
    required String avatarImageUrl,
    required this.email,
    required this.friends,
    required this.rooms,
  }) : super(uid: uid, name: name, avatarImageUrl: avatarImageUrl) {
    // logger.info('CurrentUser was created: ${toMap()}');
  }

  CurrentUser.fromMap(JsonMap map)
      : email = map['email'] as String,
        friends =
            (map['friends'] as List<dynamic>).map((e) => e.toString()).toList(),
        rooms =
            (map['rooms'] as List<dynamic>).map((e) => e.toString()).toList(),
        super.fromMap(map) {
    // logger.info('CurrentUser was created: ${toMap()}');
  }

  final String email;
  final List<String> friends;
  final List<String> rooms;

  @override
  JsonMap toMap() {
    final map = super.toMap();
    map['email'] = email;
    map['friends'] = friends;
    map['rooms'] = rooms;
    return map;
  }
}
