import 'package:flutter/material.dart';
import 'package:snypix_flutter/core/values/consts.dart';

class LoginHeader extends StatelessWidget {
  static const message = "Show your world as it is";

  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Image.asset(
        loginLogoPath,
        filterQuality: FilterQuality.high,
        height: 200,
      ),
      const SizedBox(height: 10),
      Text(message, style: Theme.of(context).textTheme.titleSmall)
    ]));
  }
}
