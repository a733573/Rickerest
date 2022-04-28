import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rickerest/app/data/services/auth_service.dart';

import '../services/firestore_service.dart';
import 'message.dart';

class Room {
  Room({
    String? id,
    this.latestMessage,
    required this.members,
    String? name,
    String? avatarImageUrl,
  })  : _isNew = id == null,
        id = id ??= FirestoreService.to.db.collection('rooms').doc().id,
        _name = name,
        _avatarImageUrl = avatarImageUrl;

  Room.fromJson(JsonMap json)
      : _isNew = json['id'] == null,
        id = json['id'] as String? ??
            FirestoreService.to.db.collection('rooms').doc().id,
        latestMessage = json['latestMessage'] == null
            ? null
            : Message.fromJson(json['latestMessage'] as JsonMap),
        members = (json['members'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        _name = json['name'] as String?,
        _avatarImageUrl = json['avatarImageUrl'] as String?;

  final String id;
  Message? latestMessage;
  final List<String> members;
  final String? _name;
  final String? _avatarImageUrl;

  String get name =>
      _name ??
      FirestoreService.to.friendUsers
          .firstWhere((friendUser) => friendUser.uid == otherMembers.first)
          .name;

  String get avatarImageUrl =>
      _avatarImageUrl ??
      FirestoreService.to.friendUsers
          .firstWhere((friendUser) => friendUser.uid == otherMembers.first)
          .avatarImageUrl;

  List<String> get otherMembers =>
      members.where((uid) => uid != AuthService.to.uid).toList();

  DocumentReference get ref =>
      FirestoreService.to.db.collection('rooms').doc(id);

  final bool _isNew;

  bool get isNew => _isNew;

  bool get isPersonal => _name == null;

  bool get isGroup => !isPersonal;

  JsonMap toJson() {
    return {
      'id': id,
      'latestMessage': latestMessage?.toJson(),
      'members': members,
      'name': _name,
      'avatarImageUrl': _avatarImageUrl
    };
  }

// static ChatUser chatUserFromUid(String uid) {
//   return FirestoreService.to.currentUser!.friends
//           .firstWhereOrNull((e) => e.uid == uid)
//           ?.toChatUser() ??
//       FirestoreService.to.currentUser!.toChatUser();
// }

// void init(String? name, String? avatarImageUrl) {
//   final friendMember = _friendMembers(members).first;
//   this.name = name ?? friendMember.firstName!;
//   this.avatarImageUrl = avatarImageUrl ?? friendMember.profileImage!;
// }
}
