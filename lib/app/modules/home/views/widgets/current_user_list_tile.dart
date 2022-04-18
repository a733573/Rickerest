import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rickerest/app/modules/home/controllers/home_controller.dart';

class CurrentUserTile extends StatelessWidget {
  const CurrentUserTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      title: Obx(() {
        return Text(
          HomeController.to.currentUserData['name']!,
          style: Theme.of(context).textTheme.headline6,
        );
      }),
      avatar: Obx(() {
        return GFAvatar(
          size: GFSize.LARGE,
          backgroundImage: NetworkImage(
            HomeController.to.currentUserData['avatarImageUrl']!.isNotEmpty
                ? HomeController.to.currentUserData['avatarImageUrl']!
                : 'https://firebasestorage.googleapis.com/v0/b/rickerest.appspot.com/o/default_profile_image.png?alt=media&token=372ebb78-6004-4850-ae9e-52f4b7b09cb8',
          ),
        );
      }),
    );
  }
}
