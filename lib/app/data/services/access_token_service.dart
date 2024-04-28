import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/services/autentication_service.dart';
import 'package:snypix_flutter/app/routes/app_routes.dart';

class AccessTokenService extends GetxService {
  AuthenticationService get _authService => Get.find<AuthenticationService>();

  Future<String> obtainAccessToken() async {
    final token = await _authService.getOrRenewAccessToken();
    if (token == null) {
      // TODO check that the login page returns to the previous page
      await Get.toNamed(AppRoutes.login);
    }
    return token!;
  }
}
