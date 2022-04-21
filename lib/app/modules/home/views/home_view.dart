import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/utils/logger.dart';
import 'package:rickerest/app/data/models/current_user_model.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';
import 'package:rickerest/app/global/widgets/custom_bottom_navigation_bar.dart';
import 'package:rickerest/app/modules/home/controllers/home_controller.dart';
import 'package:rickerest/app/modules/home/views/widgets/current_user_tile.dart';
import 'package:rickerest/app/modules/home/views/widgets/friends_tile.dart';
import 'package:rickerest/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.addFriends),
            icon: const Icon(Icons.person_add),
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        initialData: FirestoreService.to.currentUserDocumentCache,
        stream: FirestoreService.to.currentUserStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            logger.warning('Snapshot has error.');
            return const SizedBox();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }

          FirestoreService.to.currentUserDocumentCache = snapshot.data;
          final isFromCache = snapshot.data?.metadata.isFromCache;
          if (isFromCache != null && !isFromCache) {
            logger.warning('isFromCache=$isFromCache');
          }

          final data = snapshot.data?.data()! as Map<String, dynamic>?;
          FirestoreService.to.currentUserModel = CurrentUserModel(data!);
          final friendTiles = FirestoreService.to.currentUserModel!.friendsList
              .map((friendUserModel) => FriendTile(friendUserModel));

          return ListView(
            children: [
              CurrentUserTile(FirestoreService.to.currentUserModel!),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Friends',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              ...friendTiles
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 0),
    );
  }
}
