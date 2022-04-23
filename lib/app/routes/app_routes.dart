part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const signIn = _Paths.signIn;
  static const home = _Paths.home;
  static const addFriends = _Paths.addFriends;
  static const chats = _Paths.chats;
  static const room = _Paths.room;
  static const settings = _Paths.settings;
  static const editProfile = _Paths.editProfile;
}

abstract class _Paths {
  _Paths._();
  static const signIn = '/sign-in';
  static const home = '/home';
  static const addFriends = '/home/add-friends';
  static const chats = '/chats';
  static const room = '/chats/room';
  static const settings = '/settings';
  static const editProfile = '/settings/edit-profile';
}
