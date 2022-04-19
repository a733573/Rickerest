import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      // headerBuilder: (context, constraints, _) => const IconImage(),
      // sideBuilder: (context, constraints) => const IconImage(),
      providerConfigs: const [
        GoogleProviderConfiguration(
          clientId: '1039744153156-56ibedqkldacjspcgb35nbqaq325d023'
              '.apps.googleusercontent.com',
        ),
        EmailProviderConfiguration(),
      ],
      actions: [
        AuthStateChangeAction<UserCreated>((context, userCreated) async {
          final user = userCreated.credential.user!;
          await controller.createUser(
            uid: user.uid,
            name: user.email!,
            email: user.email!,
          );
        }),
      ],
    );
  }
}
