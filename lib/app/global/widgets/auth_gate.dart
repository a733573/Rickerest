import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:nil/nil.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
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
        return const SignInScreen(
          // headerBuilder: (context, constraints, _) => const IconImage(),
          // sideBuilder: (context, constraints) => const IconImage(),
          providerConfigs: [
            GoogleProviderConfiguration(
              clientId: '1039744153156-56ibedqkldacjspcgb35nbqaq325d023'
                  '.apps.googleusercontent.com',
            ),
            EmailProviderConfiguration(),
          ],
        );
      },
    );
  }
}
