import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/utils/logger.dart';
import 'package:rickerest/app/data/models/user.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';
import 'package:rickerest/app/global/widgets/custom_bottom_navigation_bar.dart';
import 'package:rickerest/app/modules/home/controllers/home_controller.dart';
import 'package:rickerest/app/modules/home/views/widgets/current_user_tile.dart';
import 'package:rickerest/app/modules/home/views/widgets/home_friend_tile.dart';
import 'package:rickerest/app/routes/app_pages.dart';

import '../../../data/models/current_user.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.addFriends),
            icon: const Icon(Icons.person_add),
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        initialData: FirestoreService.to.currentUserSnapshotCache,
        stream: FirestoreService.to.currentUserStream,
        builder: (
          BuildContext context,
          AsyncSnapshot<DocumentSnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            logger.warning('Snapshot has error.');
            return const SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          // final isFromCache = snapshot.data?.metadata.isFromCache;
          // if (isFromCache != null && !isFromCache) {
          //   logger.warning('isFromCache=$isFromCache');
          // }

          // final previousRoomsLength =
          //     FirestoreService.to.currentUser?.rooms.length;

          FirestoreService.to.currentUserSnapshotCache = snapshot.data;
          final data = snapshot.data!.data()! as JsonMap;
          FirestoreService.to.currentUser = CurrentUser.fromMap(data);

          // if (FirestoreService.to.currentUser!.rooms.length !=
          //     previousRoomsLength) {
          //   controller.loadRooms();
          //   logger.info('Loading rooms.');
          // }
          return ListView(
            children: [
              // ignore: prefer_const_constructors
              CurrentUserTile(),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  '${'friends'.tr}: '
                  '${FirestoreService.to.currentUser!.friends.length}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              FirestoreService.to.currentUser!.friends.isEmpty
                  ? const SizedBox()
                  : StreamBuilder<QuerySnapshot>(
                      initialData: FirestoreService.to.friendUsersSnapshotCache,
                      stream: FirestoreService.to.friendUsersStream,
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot,
                      ) {
                        if (snapshot.hasError) {
                          logger.warning('Snapshot has error.');
                          return const SizedBox();
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox();
                        }
                        final isFromCache = snapshot.data?.metadata.isFromCache;
                        if (isFromCache != null && !isFromCache) {
                          logger.warning('isFromCache=$isFromCache');
                        }
                        FirestoreService.to.friendUsersSnapshotCache =
                            snapshot.data;
                        FirestoreService.to.friendUsers =
                            snapshot.data!.docs.map((doc) {
                          final data = doc.data()! as JsonMap;
                          return User.fromMap(data);
                        }).toList();
                        return ListView(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          children: FirestoreService.to.friendUsers
                              .map((friendUser) => HomeFriendTile(friendUser))
                              .toList(),
                        );
                      },
                    ),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 0),
    );
  }
}
