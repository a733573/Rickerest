import 'package:get/get.dart';

class HomeController extends GetxController {
  // 入力されたメールアドレス
  String newUserEmail = '';

  // 入力されたパスワード
  String newUserPassword = '';

  //　登録・ログインに関する情報を表示
  final RxString _infoText = ''.obs;

  String get infoText => _infoText.value;

  set infoText(String value) => _infoText.value = value;

  // 入力されたメールアドレス（ログイン）
  String loginUserEmail = '';

  // 入力されたパスワード（ログイン）
  String loginUserPassword = '';
}
