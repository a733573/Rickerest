import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

import '../../../core/utils/logger.dart';
import '../../../data/models/room.dart';
import '../../../global/widgets/custom_bottom_navigation_bar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/chats_controller.dart';

class ChatsView extends GetView<ChatsController> {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('chats'.tr),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.createRoom),
            icon: const Icon(Icons.add_comment),
          )
        ],
      ),
      body: FirestoreService.to.currentUser!.rooms.isEmpty
          ? const SizedBox()
          : StreamBuilder<QuerySnapshot>(
              initialData: FirestoreService.to.roomsCache,
              stream: FirestoreService.to.roomsStream,
              builder: (
                BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot,
              ) {
                if (snapshot.hasError) {
                  logger.warning('Snapshot has error.');
                  return const SizedBox();
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }
                final isFromCache = snapshot.data?.metadata.isFromCache;
                if (isFromCache != null && !isFromCache) {
                  logger.warning('isFromCache=$isFromCache');
                }

                FirestoreService.to.roomsCache = snapshot.data;
                FirestoreService.to.rooms = snapshot.data!.docs
                    .map((doc) => Room.fromJson(doc.data()! as JsonMap))
                    .toList();
                return ListView(
                  children: FirestoreService.to.rooms
                      .map(
                        (room) => GFListTile(
                          title: Text(
                            room.name,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          subTitle: Text(
                            controller.latestMessageText(room),
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.6),
                            ),
                          ),
                          avatar: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(room.avatarImageUrl),
                              backgroundColor: Colors.white,
                            ),
                          ),
                          icon: Text(
                            controller.latestMessageCreatedAt(
                              room.latestMessage!.createdAt,
                            ),
                            style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.6),
                            ),
                          ),
                          onTap: () => Get.toNamed(
                            Routes.room,
                            arguments: room,
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        selectedIndex: 1,
      ),
    );
  }
}
