import 'package:rickerest/app/data/models/friend_user_model.dart';
import 'package:rickerest/app/data/services/auth_service.dart';

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
    // logger.info('New instance has been created.');
  }

  final String uid = AuthService.to.uid!;
  late final String name;
  late final String email;
  late final String avatarImageUrl;
  late final List<FriendUserModel> friendsList;
}
