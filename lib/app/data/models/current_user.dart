import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:rickerest/app/data/models/friend_user.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/storage_service.dart';

class CurrentUser {
  CurrentUser(
    this.name,
    this.email,
    this.avatarImageUrl,
    this.friendsList,
    this.rooms,
  );

  CurrentUser.fromMap(Map<String, dynamic> map) {
    name = map['name'] as String;
    email = map['email'] as String;
    avatarImageUrl = map['avatarImageUrl'] as String? ?? defaultAvatarImageUrl;
    final friends = map['friends'] as Map<String, dynamic>?;
    friendsList = friends?.entries
            .map(
              (e) => FriendUser.fromMap(
                uid: e.key,
                map: e.value as Map<String, dynamic>,
              ),
            )
            .toList() ??
        [];
    friendsList.sort((a, b) => a.name.compareTo(b.name));
  }

  final String uid = AuthService.to.uid!;
  late final String name;
  late final String email;
  late final String avatarImageUrl;
  late final List<FriendUser> friendsList;
  late final List<String> rooms;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'avatarImageUrl': avatarImageUrl,
      'friends': {...friendsList.map((e) => e.toMap)}
    };
  }

  ChatUser toChatUser() {
    return ChatUser(id: uid, firstName: name, profileImage: avatarImageUrl);
  }
}
