import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/services/autentication_service.dart';
import 'package:snypix_flutter/app/data/services/user_profile_service.dart';
import 'package:snypix_flutter/app/routes/app_routes.dart';
import 'package:snypix_flutter/core/widgets/wide_rouded_button.dart';

class HomePage extends GetView {
  UserProfileService get _profileService => Get.find<UserProfileService>();
  AuthenticationService get _authService => Get.find<AuthenticationService>();

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Obx(() => Text('Welcome, ${_profileService.current.username}!')),
        WideRoundedButton(
          text: 'Back to login',
          color: Colors.red,
          onPressed: () {
            Get.offNamed(AppRoutes.login);
          },
        ),
        WideRoundedButton(
          text: 'Sign out',
          color: Colors.blue,
          onPressed: () async {
            await _authService.signOut();
            Get.offAllNamed(AppRoutes.login);
          },
        ),
      ]),
    );
  }
}
