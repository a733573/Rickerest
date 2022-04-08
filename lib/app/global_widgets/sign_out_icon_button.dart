import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignOutIconButton extends StatelessWidget {
  const SignOutIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Get.offNamed('/sign-in');
      },
      icon: const Icon(Icons.logout),
    );
  }
}
