import 'message.dart';

class Room {
  Room({
    required this.id,
    required this.latestMessage,
    required this.members,
    String? name,
    String? avatarImageUrl,
  })  : _name = name,
        _avatarImageUrl = avatarImageUrl;

  Room.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        latestMessage =
            Message.fromMap(map['latestMessage'] as Map<String, dynamic>),
        members =
            (map['members'] as List<dynamic>).map((e) => e.toString()).toList(),
        _name = map['name'] as String?,
        _avatarImageUrl = map['avatarImageUrl'] as String?;

  final String id;
  final Message latestMessage;
  final List<String> members;
  final String? _name;
  final String? _avatarImageUrl;

  // TODO
  String get name => _name ?? '';

  // TODO
  String get avatarImageUrl => _avatarImageUrl ?? '';

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
