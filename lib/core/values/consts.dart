import 'package:flutter/material.dart';

abstract class BackendConfig {
  static const baseUrl = 'http://ucuc36pg1a8crkjd.myfritz.net:18774/rest';
}

abstract class LoginImage {
  static const backgroundPath = 'assets/images/login_bg.jpg';
  static const logoPath = 'assets/images/logo_login.png';
}

abstract class Size {
  static const margin = 40.0;
  static const spacing = 10.0;
}

abstract class FixedSpace {
  static const vertical = SizedBox(height: Size.spacing);
}

abstract class RoundedBorder {
  static const wideRadius = 20.0;
  static const wide = BorderRadius.all(Radius.circular(wideRadius));

  static const narrowRadius = 20.0;
  static const narrow = BorderRadius.all(Radius.circular(narrowRadius));
}
