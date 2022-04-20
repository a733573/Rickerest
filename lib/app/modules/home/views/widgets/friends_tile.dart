import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:rickerest/app/data/models/friend_user_model.dart';

class FriendTile extends StatelessWidget {
  const FriendTile(this.friendUserModel, {Key? key}) : super(key: key);
  final FriendUserModel friendUserModel;

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          friendUserModel.name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      avatar: GFAvatar(
        size: GFSize.SMALL,
        backgroundImage: NetworkImage(friendUserModel.avatarImageUrl),
      ),
    );
  }
}
