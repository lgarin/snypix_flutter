import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/home/home_page.dart';
import 'package:snypix_flutter/app/modules/login/login_page.dart';
import 'package:snypix_flutter/app/modules/test/test_page.dart';
import 'package:snypix_flutter/app/routes/app_binds.dart';
import 'package:snypix_flutter/app/routes/app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.login, page: LoginPage.new, binds: AppBinds.login),
    GetPage(name: AppRoutes.home, page: HomePage.new, binds: AppBinds.home),
    GetPage(name: AppRoutes.test, page: TestPage.new, binds: AppBinds.test),
  ];
}
