import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/login/login_controller.dart';
import 'package:snypix_flutter/app/modules/login/widgets/login_header.dart';
import 'package:snypix_flutter/app/modules/login/widgets/login_widget.dart';
import 'package:snypix_flutter/core/values/consts.dart';

class LoginPage extends GetView<LoginController> {
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
                image: AssetImage(LoginImage.backgroundPath))),
        child: _buildContent());
  }

  ListView _buildContent() {
    return ListView(children: <Widget>[
      Container(
          margin: const EdgeInsets.only(
              top: Size.margin, left: Size.margin, right: Size.margin),
          child: const LoginHeader()),
      Container(
        margin: const EdgeInsets.all(Size.margin),
        child: const LoginWidget(),
      ),
    ]);
  }
}
