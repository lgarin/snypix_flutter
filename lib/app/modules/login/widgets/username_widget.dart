import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/login/login_controller.dart';
import 'package:snypix_flutter/core/widgets/wide_rounded_field.dart';

class UsernameWidget extends GetView<LoginController> {
  static const label = 'Username';

  const UsernameWidget({super.key});

  // FIXME : use library for that
  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return '$label required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WideRoundedField(
      child: TextFormField(
        autofocus: !controller.hasUsernameInput(),
        initialValue: controller.username,
        onSaved: controller.setUsername,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            hintText: label, icon: Icon(Icons.perm_identity)),
        validator: _validate,
      ),
    );
  }
}
