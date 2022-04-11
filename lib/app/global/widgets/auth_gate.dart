import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:rickerest/app/global/widgets/senbei_bayashi_image.dart';

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
          return const SizedBox();
        }
        // 未ログイン
        return Scaffold(
          appBar: AppBar(
            title: const Text('Sign in'),
            elevation: 0,
            backgroundColor: Colors.brown.withOpacity(0.5),
            automaticallyImplyLeading: false,
          ),
          body: SignInScreen(
            headerBuilder: (context, constraints, _) =>
                const SenbeiBayashiImage(),
            sideBuilder: (context, constraints) => const SenbeiBayashiImage(),
            providerConfigs: const [
              GoogleProviderConfiguration(
                clientId: '1039744153156-56ibedqkldacjspcgb35nbqaq325d023'
                    '.apps.googleusercontent.com',
              ),
              EmailProviderConfiguration(),
            ],
          ),
        );
      },
    );
  }
}
