import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/routes/app_pages.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  final int selectedIndex;

  void _onItemTapped(int index) {
    {
      if (selectedIndex == index) {
        return;
      }
      if (index == 0) {
        Get.offNamed(Routes.home);
      }
      if (index == 1) {
        Get.offNamed(Routes.chats);
      }
      if (index == 2) {
        Get.offNamed(Routes.settings);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wechat),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: '',
        ),
      ],
      showUnselectedLabels: false,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: const IconThemeData(size: 30),
      unselectedIconTheme: const IconThemeData(size: 25),
    );
  }
}
