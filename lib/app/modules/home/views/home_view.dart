import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/global/widgets/custom_bottom_navigation_bar.dart';
import 'package:rickerest/app/modules/home/bindings/add_friends_binding.dart';
import 'package:rickerest/app/modules/home/views/add_friends_view.dart';
import 'package:rickerest/app/modules/home/views/widgets/current_user_tile.dart';
import 'package:rickerest/app/modules/home/views/widgets/friend_list_view.dart';
import 'package:rickerest/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

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
            onPressed: () => Get.to(
              () => const AddFriendsView(),
              routeName: '${Routes.home}/add-friends',
              binding: AddFriendsBinding(),
            ),
            icon: const Icon(Icons.person_add),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CurrentUserTile(),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              'Friends',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const FriendListView(),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 0),
    );
  }
}
