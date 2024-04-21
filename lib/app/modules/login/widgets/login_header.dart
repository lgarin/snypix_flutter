import 'package:flutter/material.dart';
import 'package:snypix_flutter/core/values/consts.dart';

class LoginHeader extends StatelessWidget {
  static const message = "Show your world as it is";
  static const logoHeight = 200.0;

  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Image.asset(
        LoginImage.logoPath,
        filterQuality: FilterQuality.high,
        height: logoHeight,
      ),
      FixedSpace.vertical,
      Text(message, style: Theme.of(context).textTheme.titleSmall)
    ]));
  }
}
