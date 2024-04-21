import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/login/login_controller.dart';
import 'package:snypix_flutter/app/modules/login/widgets/automatic_login_widget.dart';
import 'package:snypix_flutter/app/modules/login/widgets/login_button.dart';
import 'package:snypix_flutter/app/modules/login/widgets/password_widget.dart';
import 'package:snypix_flutter/app/modules/login/widgets/register_button.dart';
import 'package:snypix_flutter/app/modules/login/widgets/username_widget.dart';
import 'package:snypix_flutter/core/widgets/loading_circle_widget.dart';
import 'package:snypix_flutter/core/widgets/simple_dialogs.dart';
import 'package:snypix_flutter/core/values/consts.dart';

class LoginWidget extends GetView<LoginController> {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.obx((state) => _buildForm(),
        onLoading: const LoadingCircleWidget(), onError: showUnexpectedError);
  }

  Widget _buildForm() {
    return Form(
        key: controller.loginFormKey,
        autovalidateMode: controller.hasInput()
            ? AutovalidateMode.always
            : AutovalidateMode.onUserInteraction,
        child: const Column(
          children: <Widget>[
            UsernameWidget(),
            FixedSpace.vertical,
            PasswordWidget(),
            FixedSpace.vertical,
            AutomaticLoginWidget(),
            FixedSpace.vertical,
            LoginButton(),
            FixedSpace.vertical,
            RegisterButton()
          ],
        ));
  }
}
