import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:rickerest/app/core/utils/logger.dart';
import 'package:rickerest/app/data/models/room.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';
import 'package:rickerest/app/routes/app_pages.dart';

import '../../../global/widgets/custom_bottom_navigation_bar.dart';
import '../controllers/chats_controller.dart';

class ChatsView extends GetView<ChatsController> {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        initialData: FirestoreService.to.roomsCache,
        stream: FirestoreService.to.roomsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            logger.warning('Snapshot has error.');
            return const SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          FirestoreService.to.roomsCache = snapshot.data;
          // final isFromCache = snapshot.data?.metadata.isFromCache;
          // if (isFromCache != null && !isFromCache) {
          //   logger.info('isFromCache=$isFromCache');
          // }

          // final data = snapshot.data?.data()! as Map<String, dynamic>?;
          // FirestoreService.to.currentUserModel = CurrentUserModel(data!);
          // final friendTiles = FirestoreService.to.currentUserModel!.friendsList
          //     .map((friendUserModel) => FriendTile(friendUserModel));

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final data = document.data()! as Map<String, dynamic>;
              final room = Room.fromMap(document.id, data);
              // final friendUid = (data['members'] as List<dynamic>)
              //     .firstWhere((e) => e != AuthService.to.uid!) as String;
              // final friendUserModel = FirestoreService
              //     .to.currentUserModel!.friendsList
              //     .firstWhere((e) {
              //   return e.uid == friendUid;
              // });
              // final latestMessage =
              //     data['latestMessage'] as Map<String, dynamic>;
              return GFListTile(
                title: Text(
                  room.name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                subTitle: Opacity(
                  opacity: 0.6,
                  child: Text(
                    room.latestMessage.text,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                avatar: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(room.avatarImageUrl),
                  ),
                ),
                onTap: () => Get.toNamed(
                  Routes.room,
                  arguments: room,
                ),
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        selectedIndex: 1,
      ),
    );
  }
}
