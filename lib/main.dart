import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/routes/app_binds.dart';
import 'package:snypix_flutter/app/routes/app_pages.dart';
import 'package:snypix_flutter/app/routes/app_routes.dart';
import 'package:snypix_flutter/app/ui/app_theme.dart';
import 'package:snypix_flutter/core/values/strings.dart';

void main() {
  Get.reset();
  runApp(GetMaterialApp(
    title: AppText.title,
    theme: AppTheme.data,
    initialRoute: AppRoutes.initial,
    getPages: AppPages.pages,
    binds: AppBinds.global,
  ));
}
