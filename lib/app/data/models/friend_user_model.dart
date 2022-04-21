import 'package:rickerest/app/data/services/storage_service.dart';

class FriendUserModel {
  FriendUserModel({required this.uid, required Map<String, dynamic> data}) {
    name = data['name'] as String;
    avatarImageUrl = data['avatarImageUrl'] as String? ??
        defaultAvatarImageUrl;
  }

  final String uid;
  late final String name;
  late final String avatarImageUrl;
}
