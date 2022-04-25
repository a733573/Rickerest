import 'package:dash_chat_2/dash_chat_2.dart';

class User {
  User({required this.uid, required this.name, required this.avatarImageUrl}) {
    // logger.info('User was created: ${toMap()}');
  }

  User.fromMap(Map<String, dynamic> map)
      : uid = map['uid'] as String,
        name = map['name'] as String,
        avatarImageUrl = map['avatarImageUrl'] as String {
    // logger.info('User was created: ${toMap()}');
  }

  final String uid;
  final String name;
  final String avatarImageUrl;

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'name': name, 'avatarImageUrl': avatarImageUrl};
  }

  ChatUser toChatUser() {
    return ChatUser(id: uid, firstName: name, profileImage: avatarImageUrl);
  }
}
