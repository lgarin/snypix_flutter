import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/services/credential_store_service.dart';
import 'package:snypix_flutter/app/modules/login/login_controller.dart';
import 'package:snypix_flutter/app/modules/login/login_page.dart';

void main() {
  Get.reset();
  Get.lazyPut(() => CredentialStoreService());
  Get.lazyPut(() => LoginController());
  runApp(const MainApp());
}

class MainApp extends GetMaterialApp {
  const MainApp({super.key});

  // TODO fix theme
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snypix',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color.fromARGB(255, 54, 71, 163),
        primaryColorDark: const Color.fromARGB(255, 43, 56, 130),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 63, 79, 167)),
        textTheme: const TextTheme(
            labelLarge: TextStyle(fontSize: 18, color: Colors.white),
            titleSmall: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white)),
      ),
      home: const LoginPage(),
    );
  }
}
