import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/services/media_query_service.dart';
import 'package:snypix_flutter/app/modules/content/content_controller.dart';
import 'package:snypix_flutter/app/modules/home/gallery_controller.dart';
import 'package:snypix_flutter/core/values/strings.dart';

class HomeController extends ContentController
    with GetSingleTickerProviderStateMixin {
  static const _galleryTabIndex = 0;
  static const _feedTabIndex = 1;
  static const _mapTabIndex = 2;

  final _currentTabIndex = _galleryTabIndex.obs;
  late TabController _categoryController;

  final _searching = false.obs;
  final _keywordController = TextEditingController();
  final _suggestionsController = SuggestionsController<String>();

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
    _keywordController.dispose();
    _suggestionsController.dispose();
    super.onClose();
  }

  GalleryController get currentGalleryController {
    final token = ExtendedMediaCategory.tokens[categoryController.index];
    return Get.find<GalleryController>(tag: token);
  }

  void _loadCategory() {
    if (categoryController.indexIsChanging) {
      return;
    }
    final galleryController = currentGalleryController;
    if (galleryController.state.isEmpty ||
        galleryController.searchKeyword != _keywordController.text) {
      galleryController.refreshData(_keywordController.text);
    }
  }

  TabController get categoryController => _categoryController;
  int get currentTabIndex => _currentTabIndex.value;
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

  TextEditingController get editingController => _keywordController;
  SuggestionsController<String> get suggestionsController =>
      _suggestionsController;
  bool get searching => _searching.value;

  void switchSearching() {
    if (!searching) {
      _searching.value = true;
    } else {
      _searching.value = false;
      editingController.clear();
      final galleryController = currentGalleryController;
      galleryController.refreshData('');
    }
  }

  void beginSearch(String keywords) {
    if (keywords.isNotEmpty) {
      editingController.text = keywords;
      final galleryController = currentGalleryController;
      galleryController.refreshData(keywords);
    } else {
      switchSearching();
    }
  }

  Future<List<String>> fetchSuggestions(String pattern) {
    return Get.find<MediaQueryService>().suggestTags(pattern, 5);
  }
}
