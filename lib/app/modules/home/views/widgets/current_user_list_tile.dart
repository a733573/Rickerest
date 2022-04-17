import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CurrentUserListTile extends StatelessWidget {
  CurrentUserListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userName = 'Name Name';
    final avatarImageUrl =
        'https://firebasestorage.googleapis.com/v0/b/rickerest.appspot.com/o/default_profile_image.png?alt=media&token=372ebb78-6004-4850-ae9e-52f4b7b09cb8';

    return GFListTile(
      title: Text(
        userName,
        style: Theme.of(context).textTheme.headline6,
      ),
      avatar: GFAvatar(
        size: GFSize.LARGE,
        backgroundImage: NetworkImage(avatarImageUrl),
      ),
    );
  }
}
