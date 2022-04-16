import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/routes/app_pages.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key, required this.selectedIndex})
      : super(key: key);

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      initialActiveIndex: selectedIndex,
      onTap: _changeRoute,
      color: Theme.of(context).primaryColor,
      activeColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).bottomAppBarColor,
      disableDefaultTabController: false,
      style: TabStyle.react,
      items: const [
        TabItem(
          icon: Icon(Icons.home),
          title: 'Home',
        ),
        TabItem(
          icon: Icon(Icons.chat),
          title: 'Chats',
        ),
        TabItem(
          icon: Icon(Icons.settings),
          title: 'Settings',
        ),
      ],
    );
  }

  void _changeRoute(int index) {
    Get.offNamed([Routes.home, Routes.chats, Routes.settings][index]);
  }
}
