import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/routes/app_pages.dart';

class SignOutIconButton extends StatelessWidget {
  const SignOutIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Get.offAllNamed(Routes.home);
      },
      icon: const Icon(Icons.logout),
    );
  }
}
