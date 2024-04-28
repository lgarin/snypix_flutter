import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/login/login_controller.dart';
import 'package:snypix_flutter/core/widgets/checkbox_form_field.dart';
import 'package:snypix_flutter/core/widgets/wide_rounded_field.dart';
import 'package:snypix_flutter/core/values/consts.dart';

class AutomaticLoginWidget extends GetView<LoginController> {
  static const label = 'Keep me signed in';
  static const icon = Icon(Icons.vpn_key);

  const AutomaticLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return WideRoundedField(
        padding: const EdgeInsets.symmetric(vertical: FixedSpace.spacing),
        child: CheckboxFormField(
          onSaved: controller.setStoreCredential,
          initialValue: controller.storeCredential,
          title: Text(label, style: Theme.of(context).textTheme.titleMedium),
          secondary: icon,
        ));
  }
}
