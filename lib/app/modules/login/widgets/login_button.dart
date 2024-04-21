import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/login/login_controller.dart';
import 'package:snypix_flutter/core/widgets/wide_rouded_button.dart';

class LoginButton extends GetView<LoginController> {
  static const color = Color.fromARGB(255, 231, 40, 102);
  static const label = 'Login';

  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return WideRoundedButton(
        text: label, onPressed: controller.onLogin, color: color);
  }
}
