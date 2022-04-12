import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/global/widgets/auth_gate.dart';
import 'package:rickerest/app/global/widgets/custom_bottom_navigation_bar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthGate(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
          ),
          automaticallyImplyLeading: false,
        ),
        body: const SizedBox(),
        bottomNavigationBar: const CustomBottomNavigationBar(selectedIndex: 0),
      ),
    );
  }
}
