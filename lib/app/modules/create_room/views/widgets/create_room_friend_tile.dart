import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:rickerest/app/data/models/user.dart';

class CreateRoomFriendTile extends StatelessWidget {
  const CreateRoomFriendTile(this.friendUser, this.checkMap, {Key? key})
      : super(key: key);
  final User friendUser;
  final Map<String, bool> checkMap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => checkMap[friendUser.uid] = !checkMap[friendUser.uid]!,
      child: GFListTile(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        title: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            friendUser.name,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        avatar: CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(friendUser.avatarImageUrl),
          backgroundColor: Colors.white,
        ),
        icon: Obx(() {
          return Checkbox(
            value: checkMap[friendUser.uid],
            onChanged: (value) => checkMap[friendUser.uid] = value!,
          );
        }),
      ),
    );
  }
}
