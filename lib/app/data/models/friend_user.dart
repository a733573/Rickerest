import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:rickerest/app/data/services/storage_service.dart';

class FriendUser {
  FriendUser(this.uid, this.name, this.avatarImageUrl);

  FriendUser.fromMap({required this.uid, required Map<String, dynamic> map}) {
    name = map['name'] as String;
    avatarImageUrl = map['avatarImageUrl'] as String? ?? defaultAvatarImageUrl;
  }

  final String uid;
  late final String name;
  late final String avatarImageUrl;

  Map<String, dynamic> toMap() {
    return {
      uid: {'name': name, 'avatarImageUrl': avatarImageUrl}
    };
  }

  ChatUser toChatUser() {
    return ChatUser(id: uid, firstName: name, profileImage: avatarImageUrl);
  }

}
