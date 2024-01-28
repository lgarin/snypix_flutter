import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/login/login_controller.dart';
import 'package:snypix_flutter/app/modules/login/widgets/automatic_login_widget.dart';
import 'package:snypix_flutter/app/modules/login/widgets/login_button.dart';
import 'package:snypix_flutter/app/modules/login/widgets/password_widget.dart';
import 'package:snypix_flutter/app/modules/login/widgets/register_button.dart';
import 'package:snypix_flutter/app/modules/login/widgets/username_widget.dart';
import 'package:snypix_flutter/app/widgets/loading_circle_widget.dart';

class LoginWidget extends GetView<LoginController> {
  static const spacing = 10.0;

  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (!controller.isReady) {
      return const LoadingCircleWidget();
    }
    return Form(
        key: controller.loginFormKey,
        autovalidateMode: controller.hasInput()
            ? AutovalidateMode.always
            : AutovalidateMode.onUserInteraction,
        child: const Column(
          children: <Widget>[
            UsernameWidget(),
            SizedBox(height: spacing),
            PasswordWidget(),
            SizedBox(height: spacing),
            AutomaticLoginWidget(),
            SizedBox(height: spacing),
            LoginButton(),
            SizedBox(height: spacing),
            RegisterButton()
          ],
        ));
  }
}
