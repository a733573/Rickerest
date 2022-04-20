import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/size/gf_size.dart';

class CurrentUserTile extends StatelessWidget {
  const CurrentUserTile({Key? key, this.name, this.avatarImageUrl})
      : super(key: key);
  final String? name;
  final String? avatarImageUrl;

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: Text(
          name ?? '',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      avatar: GFAvatar(
        size: GFSize.LARGE,
        backgroundImage: NetworkImage(avatarImageUrl ??
            'https://firebasestorage.googleapis.com/v0/b/rickerest.appspot.com/o/default_profile_image.png?alt=media&token=e941f785-39a5-4140-9215-ee4b339c2578'),
      ),
    );
  }
}
