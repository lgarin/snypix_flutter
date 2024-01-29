import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget showUnexpectedError<T>(String? error) {
  showMessageDialog('Unexpected error', error ?? 'Something went wrong');
  return const SizedBox.shrink();
}

Future<T?> showMessageDialog<T>(String title, String message) {
  return Get.dialog<T>(
      AlertDialog(title: Text(title), content: Text(message), actions: <Widget>[
    TextButton(
      onPressed: Get.back,
      child: const Text('Dismiss'),
    )
  ]));
}

Future<bool?> showConfirmDialog(String title, String message,
    {String confirmText = 'Confirm', String cancelText = 'Cancel'}) {
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
