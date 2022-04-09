import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';

import 'widgets/senbei_bayashi_image.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot password'),
        elevation: 0,
        backgroundColor: Colors.brown.withOpacity(0.5),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder: (context, snapshot) {
          // if (!snapshot.hasData) {
          return ForgotPasswordScreen(
            // ignore: avoid_dynamic_calls
            email: Get.arguments['email'].toString(),
            sideBuilder: (context, constraints) => const SenbeiBayashiImage(),
            headerBuilder: (context, constraints, _) =>
                const SenbeiBayashiImage(),
          );
        },
        // },
      ),
    );
  }
}
