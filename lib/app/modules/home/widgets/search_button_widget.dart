import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/home/home_controller.dart';

class SearchButtonWidget extends GetView<HomeController> {
  const SearchButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => IconButton(
          icon: Icon(controller.searching ? Icons.cancel : Icons.search,
              color: Colors.white),
          tooltip: controller.searching ? 'Cancel' : 'Search',
          onPressed: controller.switchSearching,
        ));
  }
}
