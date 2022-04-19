import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/size/gf_size.dart';

class FriendsTile extends StatelessWidget {
  const FriendsTile({Key? key, this.name, this.avatarImageUrl})
      : super(key: key);
  final String? name;
  final String? avatarImageUrl;

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          name ?? '',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      avatar: GFAvatar(
        size: GFSize.SMALL,
        backgroundImage: avatarImageUrl != null
            ? NetworkImage(avatarImageUrl!)
            : Image.asset('assets/images/default_profile_image.png').image,
      ),
    );
  }
}
