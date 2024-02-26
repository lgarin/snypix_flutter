import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/login/login_page.dart';
import 'package:snypix_flutter/app/widgets/wide_rouded_button.dart';

class HomePage extends GetView {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: WideRoundedButton(
      text: 'Back to login',
      color: Colors.red,
      onPressed: () {
        Get.offNamed("/login");
      },
    ));
  }
}
