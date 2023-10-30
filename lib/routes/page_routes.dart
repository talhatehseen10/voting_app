import 'package:get/get.dart';
import 'package:voting/routes/app_routes.dart';
import 'package:voting/views/authentication/binding/login_binding.dart';
import 'package:voting/views/authentication/views/login_screen.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
  ];
}
