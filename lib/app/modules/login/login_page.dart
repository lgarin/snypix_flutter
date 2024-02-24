import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/login/login_controller.dart';
import 'package:snypix_flutter/app/modules/login/widgets/login_header.dart';
import 'package:snypix_flutter/app/modules/login/widgets/login_widget.dart';
import 'package:snypix_flutter/core/values/consts.dart';

class LoginPage extends GetView<LoginController> {
  static const margin = 40.0;

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: _buildBody());
  }

  DecoratedBox _buildBody() {
    return DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: AlignmentDirectional.bottomCenter,
                fit: BoxFit.fill,
                image: AssetImage(loginBackgroundPath))),
        child: _buildContent());
  }

  ListView _buildContent() {
    return ListView(children: <Widget>[
      Container(
          margin:
              const EdgeInsets.only(top: margin, left: margin, right: margin),
          child: const LoginHeader()),
      Container(
        margin: const EdgeInsets.all(margin),
        child: const LoginWidget(),
      ),
    ]);
  }
}
