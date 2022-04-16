import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/global/widgets/auth_gate.dart';
import 'package:rickerest/app/global/widgets/custom_bottom_navigation_bar.dart';
import 'package:rickerest/app/modules/home/views/widgets/find_account_text_field.dart';

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
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            FindAccountTextField(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Friends list',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 0),
      ),
    );
  }
}
