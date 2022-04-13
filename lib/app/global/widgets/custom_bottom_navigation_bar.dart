import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/modules/settings/controllers/settings_controller.dart';
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
    return Obx(() {
      return BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            activeIcon: Icon(Icons.chat),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: '',
          ),
        ],
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedIconTheme: IconThemeData(
          size: 30,
          color: SettingsController.to.currentThemeData.iconTheme.color,
        ),
        unselectedIconTheme: const IconThemeData(size: 25),
      );
    });
  }
}
