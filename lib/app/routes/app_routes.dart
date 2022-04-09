part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const signIn = _Paths.signIn;
  static const forgotPassword = _Paths.forgotPassword;
  static const chats = _Paths.chats;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const signIn = '/sign-in';
  static const forgotPassword = '/sign-in/forgot-password';
  static const chats = '/chats';
}
