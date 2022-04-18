import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/global/widgets/auth_gate.dart';
import 'package:rickerest/app/global/widgets/custom_bottom_navigation_bar.dart';
import 'package:rickerest/app/modules/home/views/add_friends_view.dart';
import 'package:rickerest/app/modules/home/views/widgets/current_user_list_tile.dart';
import 'package:rickerest/app/modules/home/views/widgets/friend_list_view.dart';
import 'package:rickerest/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthGate(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () => Get.to(
                () => AddFriendsView(),
                routeName: '${Routes.home}/add-friends',
              ),
              icon: const Icon(Icons.person_add),
            )
          ],
        ),
        body: Center(
          child: SizedBox(
            width: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CurrentUserTile(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Friends',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                const FriendListView(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 0),
      ),
    );
  }
}
