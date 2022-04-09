import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('404 ERROR'),
        elevation: 0,
        backgroundColor: Colors.brown.withOpacity(0.5),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '404',
              style: TextStyle(fontSize: 70),
            ),
            const SizedBox(height: 20),
            const Text(
              'Page not found',
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Take me back to',
                  style: TextStyle(fontSize: 30),
                ),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.home),
                  child: const Text(
                    'Home',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
