import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:snypix_flutter/app/modules/home/home_controller.dart';
import 'package:snypix_flutter/core/values/consts.dart';
import 'package:snypix_flutter/core/values/strings.dart';

class KeywordSearchWidget extends GetView<HomeController> {
  static const searchIcon = Icon(Icons.search, color: Colors.white);
  static const hintText = 'Enter keyword here';
  static const backgroundStyle = TextStyle(color: Colors.grey);
  static const foregroundStyle = TextStyle(color: Colors.white);
  static const inactiveText = Text(AppText.title, style: foregroundStyle);

  const KeywordSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.searching ? _buildSearchField() : inactiveText);
  }

  Widget _buildSearchField() {
    return TypeAheadField<String>(
      onSelected: controller.beginSearch,
      suggestionsCallback: controller.fetchSuggestions,
      controller: controller.editingController,
      suggestionsController: controller.suggestionsController,
      builder: _buildTextField,
      itemBuilder: (context, suggestion) => ListTile(title: Text(suggestion)),
      hideOnError: true,
      hideOnEmpty: true,
      hideOnLoading: true,
      debounceDuration: Delay.debounce,
    );
  }

  Widget _buildTextField(BuildContext context, TextEditingController controller,
      FocusNode focusNode) {
    return TextField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: TextInputAction.search,
        style: foregroundStyle,
        decoration: const InputDecoration(
          filled: false,
          border: InputBorder.none,
          hintStyle: backgroundStyle,
          hintText: hintText,
          icon: searchIcon,
        ));
  }
}
