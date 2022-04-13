import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/theme/app_theme.dart';
import 'package:rickerest/app/routes/app_pages.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key, required this.selectedIndex})
      : super(key: key);

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      initialActiveIndex: selectedIndex,
      onTap: _onItemTapped,
      color: currentThemeData(context).primaryColor,
      activeColor: currentThemeData(context).primaryColor,
      backgroundColor: currentThemeData(context).bottomAppBarColor,
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

  void _onItemTapped(int index) {
    Get.offNamed([Routes.home, Routes.chats, Routes.settings][index]);
  }

  ThemeData currentThemeData(BuildContext context) {
    return isDarkTheme(context) ? AppTheme.dark : AppTheme.light;
  }

  bool isDarkTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }
}
