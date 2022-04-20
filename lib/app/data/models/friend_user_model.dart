class FriendUserModel {
  FriendUserModel({required this.uid, required Map<String, dynamic> data}) {
    name = data['name'] as String;
    avatarImageUrl = data['avatarImageUrl'] as String? ?? defaultAvatarImageUrl;
    // logger.info('FriendUserModel has been created.');
  }

  final String uid;
  late final String name;
  late final String avatarImageUrl;
}

const String defaultAvatarImageUrl =
    'https://firebasestorage.googleapis.com/v0/b/rickerest.appspot.com/o/default_profile_image.png?alt=media&token=e941f785-39a5-4140-9215-ee4b339c2578';
