import 'package:flutter/material.dart';

abstract class BackendConfig {
  static const baseUrl = 'http://ucuc36pg1a8crkjd.myfritz.net:18774/rest';
}

abstract class LoginImage {
  static const backgroundPath = 'assets/images/login_bg.jpg';
  static const logoPath = 'assets/images/logo_login.png';
}

abstract class FixedSpace {
  static const margin = 40.0;
  static const spacing = 10.0;
  static const vertical = SizedBox(height: spacing);
  static const empty = SizedBox(height: 0, width: 0);
  static const padding = EdgeInsets.all(spacing);
}

abstract class RoundedBorder {
  static const wideRadius = 20.0;
  static const wide = BorderRadius.all(Radius.circular(wideRadius));

  static const narrowRadius = 20.0;
  static const narrow = BorderRadius.all(Radius.circular(narrowRadius));
}

abstract class DataPaging {
  static const pageSize = 20;
}

abstract class ThumbnailDimension {
  static const width = 320;
  static const height = 480;
  static const aspectRatio = 16.0 / 9.0;
}
