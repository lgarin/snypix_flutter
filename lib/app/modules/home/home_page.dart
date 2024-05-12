import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/modules/content/content_page.dart';
import 'package:snypix_flutter/app/modules/home/gallery_view.dart';
import 'package:snypix_flutter/app/modules/home/home_controller.dart';
import 'package:snypix_flutter/app/modules/home/widgets/keyword_search_widget.dart';
import 'package:snypix_flutter/app/modules/home/widgets/search_button_widget.dart';
import 'package:snypix_flutter/app/routes/app_routes.dart';
import 'package:snypix_flutter/core/values/consts.dart';
import 'package:snypix_flutter/core/values/strings.dart';

enum _NavBarItem {
  gallery(Icons.panorama, 'Snypes'),
  feed(Icons.forum, 'Feed'),
  map(Icons.place, 'Map');

  final IconData icon;
  final String label;

  const _NavBarItem(this.icon, this.label);

  BottomNavigationBarItem buildItem() =>
      BottomNavigationBarItem(icon: Icon(icon), label: label);
}

class HomePage extends ContentPage<HomeController> {
  const HomePage({Key? key}) : super(AppRoutes.home, key: key);

  Widget _createTabContent(String? categoryToken) {
    if (controller.showGalleryTab) {
      return GalleryView(categoryToken);
    } else {
      return Container();
    }
  }

  Tab _buildTab(String category) => Tab(child: Text(category));

  @override
  AppBar buildAppBar() {
    return AppBar(
        title: const KeywordSearchWidget(),
        actions: const <Widget>[
          SearchButtonWidget(),
          FixedSpace.horizontal,
        ],
        bottom: _buildTabBar());
  }

  TabBar _buildTabBar() {
    return TabBar(
        isScrollable: true,
        controller: controller.categoryController,
        tabs: ExtendedMediaCategory.labels.map(_buildTab).toList());
  }

  @override
  Widget buildNavBar() => Obx(buildNavBarContent);

  BottomNavigationBar buildNavBarContent() {
    return BottomNavigationBar(
        currentIndex: controller.currentTabIndex,
        onTap: controller.onTabSelected,
        items: [
          _NavBarItem.gallery.buildItem(),
          _NavBarItem.feed.buildItem(),
          _NavBarItem.map.buildItem()
        ]);
  }

  @override
  Widget buildBody(BuildContext context) => Obx(_buildTabBarView);

  Widget _buildTabBarView() {
    return TabBarView(
      controller: controller.categoryController,
      physics: controller.showMapTab
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      children: ExtendedMediaCategory.tokens.map(_createTabContent).toList(),
    );
  }
}
