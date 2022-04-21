import 'package:get/get.dart';
import 'package:rickerest/app/modules/add_friedns/views/add_friends_view.dart';

import '../modules/add_friedns/bindings/add_friends_binding.dart';
import '../modules/chats/bindings/chats_binding.dart';
import '../modules/chats/views/chats_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/not_found/views/not_found_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';

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
  ];
}
