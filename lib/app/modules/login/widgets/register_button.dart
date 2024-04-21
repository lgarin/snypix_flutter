import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/login/login_controller.dart';
import 'package:snypix_flutter/core/widgets/wide_rouded_button.dart';

class RegisterButton extends GetView<LoginController> {
  static const color = Color.fromARGB(255, 32, 47, 128);
  static const label = 'Register';

  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return WideRoundedButton(
      text: label,
      onPressed: controller.onRegister,
      color: color,
    );
  }
}
