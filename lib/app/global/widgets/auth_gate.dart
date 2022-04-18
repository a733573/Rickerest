import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:nil/nil.dart';
import 'package:rickerest/app/data/services/firestore_service.dart';

import '../../data/services/auth_service.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService.to.auth.authStateChanges(),
      initialData: AuthService.to.currentUser,
      builder: (context, snapshot) {
        // ログイン済み
        if (snapshot.hasData) {
          return child;
        }
        // ローディング中
        if (snapshot.connectionState == ConnectionState.waiting) {
          return nil;
        }
        // 未ログイン
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
      },
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
