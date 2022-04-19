import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:rickerest/app/data/services/auth_service.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

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
          await createUser(
            uid: user.uid,
            name: user.email!,
            email: user.email!,
          );
        }),
      ],
    );
  }

  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
  }) {
    return FirestoreService.to.setDoc(
      colId: 'users',
      docId: AuthService.to.uid,
      data: {
        'name': name,
        'email': email,
      },
    );
  }
}
