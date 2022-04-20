import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:rickerest/app/data/models/current_user_model.dart';

class CurrentUserTile extends StatelessWidget {
  const CurrentUserTile(this.currentUserModel, {Key? key}) : super(key: key);
  final CurrentUserModel currentUserModel;

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: Text(
          currentUserModel.name,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      avatar: GFAvatar(
        size: GFSize.LARGE,
        backgroundImage: NetworkImage(currentUserModel.avatarImageUrl),
      ),
    );
  }
}
