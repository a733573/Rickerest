import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:rickerest/app/data/models/current_user_model.dart';
import 'package:rickerest/app/modules/home/views/widgets/avatar_image_dialog.dart';
import 'package:rickerest/app/routes/app_pages.dart';

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
      avatar: GestureDetector(
        onTap: () => Get.to(
          () => AvatarImageDialog(currentUserModel.avatarImageUrl),
          fullscreenDialog: true,
        ),
        child: CircleAvatar(
          radius: 34,
          backgroundImage: NetworkImage(currentUserModel.avatarImageUrl),
          backgroundColor: Colors.white,
        ),
      ),
      icon: IconButton(
        icon: const Icon(Icons.manage_accounts),
        onPressed: () => Get.toNamed(Routes.editProfile),
      ),
    );
  }
}
