import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/routes/app_pages.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key, required this.selectedIndex})
      : super(key: key);

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: _changeRoute,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      elevation: 0,
      selectedIconTheme: IconTheme.of(context),
      unselectedIconTheme: IconTheme.of(context),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(
            Icons.home,
          ),
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
    );
  }

  void _changeRoute(int index) {
    Get.offNamed([Routes.home, Routes.chats, Routes.settings][index]);
  }
}
