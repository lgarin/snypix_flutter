import 'package:flutter/material.dart';
import 'package:snypix_flutter/core/values/colors.dart';
import 'package:snypix_flutter/core/values/fonts.dart';

abstract class AppTheme {
  static final data = ThemeData(
      brightness: Brightness.light,
      primaryColor: ThemeColor.primary,
      primaryColorDark: ThemeColor.primaryDark,
      appBarTheme: const AppBarTheme(
          backgroundColor: ThemeColor.background, elevation: 5.0),
      tabBarTheme: const TabBarTheme(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: ThemeColor.background,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          elevation: 5.0),
      textTheme: const TextTheme(
          labelLarge: ThemeFont.labelLarge, titleSmall: ThemeFont.titleSmall));
}
