import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

import '../controllers/create_room_controller.dart';
import 'widgets/create_room_friend_tile.dart';

class CreateRoomView extends GetView<CreateRoomController> {
  const CreateRoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chooseFriends'.tr),
        actions: [
          TextButton(
            onPressed: controller.createRoom,
            child: Text(
              'create'.tr,
            ),
          ),
        ],
      ),
      body: ListView(
        children: FirestoreService.to.friendUsers
            .map(
              (friendUser) => CreateRoomFriendTile(
                friendUser,
                controller.checkMap,
              ),
            )
            .toList(),
      ),
    );
  }
}
