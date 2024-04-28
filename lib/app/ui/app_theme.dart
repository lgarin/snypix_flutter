import 'package:flutter/material.dart';
import 'package:snypix_flutter/core/values/colors.dart';
import 'package:snypix_flutter/core/values/fonts.dart';

abstract class AppTheme {
  static final data = ThemeData(
      brightness: Brightness.light,
      primaryColor: ThemeColor.primary,
      primaryColorDark: ThemeColor.primaryDark,
      appBarTheme:
          const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      textTheme: const TextTheme(
          labelLarge: ThemeFont.labelLarge, titleSmall: ThemeFont.titleSmall));
}
