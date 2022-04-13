import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/core/theme/app_theme.dart';
import 'package:rickerest/app/routes/app_pages.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex;

  void _onItemTapped(int index) {
    {
      switch (index) {
        case 0:
          Get.toNamed(Routes.home);
          break;
        case 1:
          Get.offNamed(Routes.chats);
          break;
        case 2:
          Get.offNamed(Routes.settings);
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      initialActiveIndex: selectedIndex,
      onTap: _onItemTapped,
      backgroundColor: currentThemeData.bottomAppBarColor,
      style: TabStyle.react,
      items: const [
        TabItem(
          icon: Icon(Icons.home_outlined),
          title: 'Home',
        ),
        TabItem(
          icon: Icon(Icons.chat_outlined),
          title: 'Chats',
        ),
        TabItem(
          icon: Icon(Icons.settings_outlined),
          title: 'Settings',
        ),
      ],
    );
  }

  ThemeData get currentThemeData =>
      Get.isDarkMode ? AppTheme.dark : AppTheme.light;
}
