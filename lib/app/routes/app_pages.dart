import 'package:get/get.dart';

import '../global/widgets/not_found_view.dart';
import '../modules/add_friedns/bindings/add_friends_binding.dart';
import '../modules/add_friedns/views/add_friends_view.dart';
import '../modules/chats/bindings/chats_binding.dart';
import '../modules/chats/views/chats_view.dart';
import '../modules/create_room/bindings/create_room_binding.dart';
import '../modules/create_room/views/create_room_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/room/bindings/room_binding.dart';
import '../modules/room/views/room_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';

// ignore_for_file: implicit_dynamic

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.signIn;

  static final notFound = GetPage(
    name: '/not-found',
    page: () => const NotFoundView(),
    transitionDuration: Duration.zero,
  );

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: _Paths.chats,
      page: () => const ChatsView(),
      binding: ChatsBinding(),
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: _Paths.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: _Paths.signIn,
      page: () => const SignInView(),
      binding: SignInBinding(),
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: _Paths.editProfile,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.addFriends,
      page: () => const AddFriendsView(),
      binding: AddFriendsBinding(),
    ),
    GetPage(
      name: _Paths.room,
      page: () => const RoomView(),
      binding: RoomBinding(),
    ),
    GetPage(
      name: _Paths.createRoom,
      page: () => const CreateRoomView(),
      binding: CreateRoomBinding(),
    ),
  ];
}
