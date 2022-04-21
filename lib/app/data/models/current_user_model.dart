import 'package:rickerest/app/data/models/friend_user_model.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/storage_service.dart';

class CurrentUserModel {
  CurrentUserModel(Map<String, dynamic> data) {
    name = data['name'] as String;
    email = data['email'] as String;
    avatarImageUrl = data['avatarImageUrl'] as String? ?? defaultAvatarImageUrl;
    final friends = data['friends'] as Map<String, dynamic>?;
    friendsList = friends?.entries
            .map(
              (e) => FriendUserModel(
                uid: e.key,
                data: e.value as Map<String, dynamic>,
              ),
            )
            .toList() ??
        [];
  }

  final String uid = AuthService.to.uid!;
  late final String name;
  late final String email;
  late final String avatarImageUrl;
  late final List<FriendUserModel> friendsList;

  Map<String, dynamic> get toJson => {
        'name': name,
        'email': email,
        'avatarImageUrl': avatarImageUrl,
        'friends': {...friendsList.map((e) => e.toJson)}
      };
}
