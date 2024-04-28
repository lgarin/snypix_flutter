import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/content/content_controller.dart';
import 'package:snypix_flutter/core/values/colors.dart';
import 'package:snypix_flutter/core/values/strings.dart';

abstract class ContentPage<T extends ContentController> extends GetView<T> {
  static const captureText = 'Capture a Snype';
  static const captureIcon = Icon(
    Icons.add_a_photo,
    color: Colors.white,
  );

  final String routeName;

  const ContentPage(this.routeName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        drawer: buildDrawer(),
        body: buildBody(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: buildCaptureButton(),
        bottomNavigationBar: buildNavBar());
  }

  AppBar buildAppBar() {
    return AppBar(title: const Text(AppText.title));
  }

  Widget? buildDrawer() {
    return null;
    // TODO implement drawer
    //return UserMenu(currentPage: pageName);
  }

  FloatingActionButton buildCaptureButton() {
    return FloatingActionButton(
        onPressed: controller.captureMedia,
        tooltip: captureText,
        backgroundColor: ThemeColor.primary,
        child: captureIcon);
  }

  Widget? buildNavBar() => null;

  Widget buildBody(BuildContext context);
}
