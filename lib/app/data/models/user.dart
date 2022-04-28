import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/utils/logger.dart';

import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'room.dart';

class User {
  User({required this.uid, required this.name, required this.avatarImageUrl}) {
    // logger.info('User was created: ${toMap()}');
  }

  User.fromMap(JsonMap map)
      : uid = map['uid'] as String,
        name = map['name'] as String,
        avatarImageUrl = map['avatarImageUrl'] as String {
    // logger.info('User was created: ${toMap()}');
  }

  final String uid;
  final String name;
  final String avatarImageUrl;

  JsonMap toMap() {
    return {'uid': uid, 'name': name, 'avatarImageUrl': avatarImageUrl};
  }

  ChatUser toChatUser() {
    return ChatUser(
      id: uid,
      firstName: name,
      profileImage: avatarImageUrl,
      customProperties: {'ref': ref},
    );
  }

  // List<Room> get rooms {
  //   return uid == AuthService.to.uid!
  //       ? FirestoreService.to.rooms
  //       : FirestoreService.to.rooms
  //       .where((room) => room.members.contains(uid))
  //       .toList();
  // }

  Future<Room> get personalRoom async {
    assert(uid != AuthService.to.uid);
    var room = FirestoreService.to.rooms.firstWhereOrNull(
      (room) => room.members.contains(uid) && room.isPersonal,
    );
    if (room == null) {
      final snapshot = await FirestoreService.to.db
          .collection('rooms')
          .where('id', whereIn: FirestoreService.to.currentUser!.rooms)
          .where('members', arrayContains: uid)
          .where('name', isEqualTo: null)
          .get();
      assert(snapshot.docs.length == 1);
      room = Room.fromJson(snapshot.docs.first.data());
      logger.info('Got a firestore document.');
    }
    return room;
  }

  DocumentReference get ref =>
      FirestoreService.to.db.collection('users').doc(uid);
}
