import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';
import 'package:rickerest/app/modules/home/views/widgets/avatar_image_dialog.dart';
import 'package:rickerest/app/routes/app_pages.dart';

class CurrentUserTile extends StatelessWidget {
  const CurrentUserTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: Text(
          FirestoreService.to.currentUser!.name,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      avatar: GestureDetector(
        onTap: () => Get.to(
          () => AvatarImageDialog(
            FirestoreService.to.currentUser!.avatarImageUrl,
          ),
          fullscreenDialog: true,
        ),
        child: CircleAvatar(
          radius: 34,
          backgroundImage:
              NetworkImage(FirestoreService.to.currentUser!.avatarImageUrl),
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
