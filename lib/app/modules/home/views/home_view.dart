import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';
import 'package:rickerest/app/global/widgets/custom_bottom_navigation_bar.dart';
import 'package:rickerest/app/modules/home/bindings/add_friends_binding.dart';
import 'package:rickerest/app/modules/home/controllers/home_controller.dart';
import 'package:rickerest/app/modules/home/views/add_friends_view.dart';
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
            onPressed: () => Get.to(
              () => const AddFriendsView(),
              routeName: '${Routes.home}/add-friends',
              binding: AddFriendsBinding(),
            ),
            icon: const Icon(Icons.person_add),
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirestoreService.to.currentUserStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          // if (snapshot.hasError) {
          //   return const SizedBox();
          // }
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const SizedBox();
          // }

          final data = snapshot.data?.data()! as Map<String, dynamic>?;
          final name = data?['name'] as String?;
          final avatarImageUrl = data?['avatarImageUrl'] as String?;
          final friends = data?['friends'] as Map<String, dynamic>?;
          final friendsTileList = friends?.entries.map((e) {
                final data = e.value as Map<String, dynamic>?;
                return FriendsTile(
                  name: data?['name'] as String?,
                  avatarImageUrl: data?['avatarImageUrl'] as String?,
                );
              }).toList() ??
              [];

          return ListView(
            children: [
              CurrentUserTile(
                name: name,
                avatarImageUrl: avatarImageUrl,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Friends',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              ...friendsTileList
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 0),
    );
  }
}
