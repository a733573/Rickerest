part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const home = _Paths.home;
  static const chats = _Paths.chats;
  static const settings = _Paths.settings;
  static const sign_in = _Paths.sign_in;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const chats = '/chats';
  static const settings = '/settings';
  static const sign_in = '/sign-in';
}
