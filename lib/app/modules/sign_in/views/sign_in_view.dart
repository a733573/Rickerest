import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';
import 'local_widgets/senbei_bayashi_image.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
        elevation: 0,
        backgroundColor: Colors.brown.withOpacity(0.5),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        initialData: FirebaseAuth.instance.currentUser,
        builder: (context, snapshot) {
          // if (!snapshot.hasData) {
          return SignInScreen(
            sideBuilder: (context, constraints) => const SenbeiBayashiImage(),
            headerBuilder: (context, constraints, _) =>
                const SenbeiBayashiImage(),
            providerConfigs: const [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                clientId: '1039744153156-56ibedqkldacjspcgb35nbqaq325d023'
                    '.apps.googleusercontent.com',
              ),
            ],
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Get.offNamed('/');
              }),
            ],
          );
        },
        // },
      ),
    );
  }
}
