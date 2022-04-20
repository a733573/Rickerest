import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:rickerest/app/data/models/friend_user_model.dart';

import 'avatar_image_dialog.dart';

class FriendTile extends StatelessWidget {
  const FriendTile(this.friendUserModel, {Key? key}) : super(key: key);
  final FriendUserModel friendUserModel;

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      title: Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Text(
          friendUserModel.name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      avatar: GestureDetector(
        onTap: () => Get.to(
          () => AvatarImageDialog(friendUserModel.avatarImageUrl),
          fullscreenDialog: true,
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(friendUserModel.avatarImageUrl),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
