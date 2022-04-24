import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:rickerest/app/core/utils/logger.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

import 'message.dart';

class Room {
  Room(
    this._id,
    this._latestMessage,
    this._members,
    String? name,
    String? avatarImageUrl,
  ) {
    init(name, avatarImageUrl);
  }

  Room.fromMap(this._id, Map<String, dynamic> map)
      : _latestMessage =
            Message.fromMap(map['latestMessage'] as Map<String, dynamic>),
        _members = (map['members'] as List<dynamic>)
            .map((uid) => chatUserFromUid(uid as String))
            .toList() {
    init(map['name'] as String?, map['avatarImageUrl'] as String?);
  }

  final String _id;
  final Message _latestMessage;
  final List<ChatUser> _members;
  late final String _name;
  late final String _avatarImageUrl;

  String get id => _id;

  Message get latestMessage => _latestMessage;

  List<ChatUser> get members => _members;

  String get name => _name;

  String get avatarImageUrl => _avatarImageUrl;

  static List<ChatUser> _friendMembers(List<ChatUser> members) {
    logger.info('c');
    return members.where((e) => e.id != AuthService.to.uid!).toList();
  }

  static ChatUser chatUserFromUid(String uid) {
    logger.info('b');
    final user = FirestoreService.to.currentUser!.friendsList
        .firstWhere((e) => e.uid == uid);
    logger.info('b');
    return user.toChatUser();
  }

  void init(String? name, String? avatarImageUrl) {
    logger.info('a');
    final friendMember = _friendMembers(_members).first;
    _name = name ?? friendMember.firstName!;
    _avatarImageUrl = avatarImageUrl ?? friendMember.profileImage!;
    logger.info('a');
  }
}
