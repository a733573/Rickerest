import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:rickerest/app/data/models/user.dart';

import 'avatar_image_dialog.dart';

class FriendTile extends StatelessWidget {
  const FriendTile(this.friendUser, {Key? key}) : super(key: key);
  final User friendUser;

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      title: Padding(
        padding: const EdgeInsets.only(left: 6),
        child: Text(
          friendUser.name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      avatar: GestureDetector(
        onTap: () => Get.to(
          () => AvatarImageDialog(friendUser.avatarImageUrl),
          fullscreenDialog: true,
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(friendUser.avatarImageUrl),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
