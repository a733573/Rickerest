import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:rickerest/app/data/models/latest_message.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

class Room {
  Room({
    required this.id,
    required this.latestMessage,
    required List<String> memberUids,
    String? name,
    String? avatarImageUrl,
  }) {
    members = memberUids.map((uid) {
      final String userName;
      final String avatarImageUrl;
      if (uid == AuthService.to.uid) {
        userName = FirestoreService.to.currentUser!.name;
        avatarImageUrl = FirestoreService.to.currentUser!.avatarImageUrl;
      } else {
        final friendUser =
            FirestoreService.to.currentUser!.friendsList.firstWhere(
          (e) => e.uid == uid,
        );
        userName = friendUser.name;
        avatarImageUrl = friendUser.avatarImageUrl;
      }
      return ChatUser(
        id: uid,
        firstName: userName,
        profileImage: avatarImageUrl,
      );
    }).toList();

    final member = members.firstWhere(
      (e) => e.id != FirestoreService.to.currentUser!.uid,
    );
    this.name = name ?? member.firstName!;
    this.avatarImageUrl = avatarImageUrl ?? member.profileImage!;
  }

  final String id;
  final LatestMessage latestMessage;
  late final List<ChatUser> members;
  late final String name;
  late final String avatarImageUrl;

  static Room fromMap(String id, Map<String, dynamic> map) {
    final latestMessage =
        LatestMessage.fromMap(map['latestMessage'] as Map<String, dynamic>);
    final memberUids =
        (map['members'] as List<dynamic>).map((e) => e.toString()).toList();
    final name = map['name'] as String?;
    return Room(
      id: id,
      latestMessage: latestMessage,
      memberUids: memberUids,
      name: name,
    );
  }
}
