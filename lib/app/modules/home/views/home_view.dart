import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              TextFormField(
                // テキスト入力のラベルを設定
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  controller.newUserEmail = value;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード（６文字以上）'),
                // パスワードが見えないようにする
                obscureText: true,
                onChanged: (String value) {
                  controller.newUserPassword = value;
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // メール/パスワードでユーザー登録
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result =
                        await auth.createUserWithEmailAndPassword(
                      email: controller.newUserEmail,
                      password: controller.newUserPassword,
                    );
                    // 登録したユーザー情報
                    final User user = result.user!;
                    controller.infoText = '登録OK：${user.email}';
                  } on Exception catch (e) {
                    // 登録に失敗した場合
                    controller.infoText = '登録NG：${e.toString()}';
                  }
                },
                child: const Text('ユーザー登録'),
              ),
              const SizedBox(height: 32),
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  controller.loginUserEmail = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  controller.loginUserPassword = value;
                },
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // メール/パスワードでログイン
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result =
                        await auth.signInWithEmailAndPassword(
                      email: controller.loginUserEmail,
                      password: controller.loginUserPassword,
                    );
                    // ログインに成功した場合
                    final User user = result.user!;
                    controller.infoText = 'ログインOK：${user.email}';
                  } on Exception catch (e) {
                    // ログインに失敗した場合
                    controller.infoText = 'ログインNG：${e.toString()}';
                  }
                },
                child: const Text('ログイン'),
              ),
              const SizedBox(height: 8),
              Obx(() => Text(controller.infoText))
            ],
          ),
        ),
      ),
    );
  }
}
