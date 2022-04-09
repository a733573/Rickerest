import 'package:get/get.dart';

import '../global/middleware/auth_middleware.dart';
import '../global/views/not_found_view.dart';
import '../modules/chats/bindings/chats_binding.dart';
import '../modules/chats/views/chats_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

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
      middlewares: [AuthMiddleware()],
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: _Paths.signIn,
      page: () => const SignInView(),
      binding: SignInBinding(),
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: _Paths.chats,
      page: () => const ChatsView(),
      binding: ChatsBinding(),
      middlewares: [AuthMiddleware()],
      transitionDuration: Duration.zero,
    ),
  ];
}
