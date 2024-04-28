import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/content/content_controller.dart';
import 'package:snypix_flutter/app/modules/home/gallery_controller.dart';
import 'package:snypix_flutter/core/values/strings.dart';

class HomeController extends ContentController
    with GetSingleTickerProviderStateMixin {
  static const _galleryTabIndex = 0;
  static const _feedTabIndex = 1;
  static const _mapTabIndex = 2;

  final _currentTabIndex = _galleryTabIndex.obs;
  final _searchKeyword = ''.obs;

  late TabController _categoryController;

  @override
  void onInit() {
    super.onInit();
    _categoryController =
        TabController(length: ExtendedMediaCategory.tokens.length, vsync: this);
    _categoryController.addListener(_loadCategory);
  }

  @override
  void onReady() {
    super.onReady();
    _loadCategory();
  }

  @override
  void onClose() {
    _categoryController.dispose();
    super.onClose();
  }

  void _loadCategory() {
    if (categoryController.indexIsChanging) {
      return;
    }
    final token = ExtendedMediaCategory.tokens[categoryController.index];
    final galleryController = Get.find<GalleryController>(tag: token);
    if (galleryController.state.isEmpty) {
      galleryController.refreshData();
    }
  }

  String get searchKeyword => _searchKeyword.value;
  int get currentTabIndex => _currentTabIndex.value;

  TabController get categoryController => _categoryController;
  bool get showGalleryTab => currentTabIndex == _galleryTabIndex;
  bool get showFeedTab => currentTabIndex == _feedTabIndex;
  bool get showMapTab => currentTabIndex == _mapTabIndex;

  void onTabSelected(int index) {
    if (index != _galleryTabIndex &&
        index != _feedTabIndex &&
        index != _mapTabIndex) {
      throw Exception('Invalid tab index: $index');
    }
    _currentTabIndex.value = index;
  }
}
