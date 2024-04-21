import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/core/values/strings.dart';

Widget showUnexpectedError<T>(String? error) {
  showMessageDialog(
      ErrorMessage.unexpectedError, error ?? ErrorMessage.somethingWrong);
  return const SizedBox.shrink();
}

Future<T?> showMessageDialog<T>(String title, String message) {
  return Get.dialog<T>(
      AlertDialog(title: Text(title), content: Text(message), actions: <Widget>[
    TextButton(
      onPressed: Get.back,
      child: const Text(ButtonText.dismiss),
    )
  ]));
}

Future<bool?> showConfirmDialog(String title, String message,
    {String confirmText = ButtonText.confirm,
    String cancelText = ButtonText.cancel}) {
  return Get.dialog<bool>(AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: <Widget>[
      TextButton(
          child: Text(confirmText),
          onPressed: () {
            Get.back(result: true);
          }),
      TextButton(
        child: Text(cancelText),
        onPressed: () {
          Get.back(result: false);
        },
      )
    ],
  ));
}
