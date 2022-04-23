import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:rickerest/app/data/services/storage_service.dart';

class FriendUser {
  FriendUser({required this.uid, required Map<String, dynamic> data}) {
    name = data['name'] as String;
    avatarImageUrl = data['avatarImageUrl'] as String? ?? defaultAvatarImageUrl;
  }

  final String uid;
  late final String name;
  late final String avatarImageUrl;

  Map<String, dynamic> get toJson => {
        uid: {'name': name, 'avatarImageUrl': avatarImageUrl}
      };

  ChatUser get toChatUser =>
      ChatUser(id: uid, firstName: name, profileImage: avatarImageUrl);
}
