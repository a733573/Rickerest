import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';
import 'package:rickerest/app/global/widgets/custom_bottom_navigation_bar.dart';
import 'package:rickerest/app/modules/home/controllers/home_controller.dart';
import 'package:rickerest/app/modules/home/views/widgets/current_user_tile.dart';
import 'package:rickerest/app/modules/home/views/widgets/friends_tile.dart';
import 'package:rickerest/app/routes/app_pages.dart';

import 'widgets/loading.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FirestoreService.to.currentUser.uid != AuthService.to.uid
          ? const Loading()
          : Scaffold(
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
              body: Obx(() {
                return ListView(
                  children: [
                    const CurrentUserTile(),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'friends'.tr,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    ...FirestoreService.to.friendUsers.map((e) {
                      return FriendTile(e);
                    }),
                  ],
                );
              }),
              bottomNavigationBar:
                  const CustomBottomNavigationBar(selectedIndex: 0),
            );
    });
  }
}
