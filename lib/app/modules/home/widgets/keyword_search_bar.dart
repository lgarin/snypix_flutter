import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/home/home_controller.dart';

class KeywordSearchBar extends GetView<HomeController> {
  const KeywordSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        builder: builder, suggestionsBuilder: suggestionsBuilder);
  }

  Future<Iterable<Widget>> suggestionsBuilder(
      BuildContext context, SearchController searchController) async {
    final suggestions =
        await controller.fetchSuggestions(searchController.text);
    return suggestions.map(_buildSuggestionItem);
  }

  Widget _buildSuggestionItem(String suggestion) {
    return ListTile(title: Text(suggestion));
  }

  Widget builder(BuildContext context, SearchController controller) {
    return const TextField();
  }
}
