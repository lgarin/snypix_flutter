import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:snypix_flutter/app/modules/content/paged_controller.dart';
import 'package:snypix_flutter/core/values/colors.dart';
import 'package:snypix_flutter/core/values/consts.dart';
import 'package:snypix_flutter/core/widgets/simple_dialogs.dart';

abstract class PagedView<E, T extends PagedController<E>>
    extends StatelessWidget {
  final String? tag;
  const PagedView({this.tag, super.key});

  T get controller => Get.find<T>(tag: tag);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: controller.refreshController,
        onLoading: controller.onLoading,
        onRefresh: controller.onRefresh,
        header: const WaterDropMaterialHeader(),
        footer: CustomFooter(
            loadStyle: LoadStyle.ShowWhenLoading, builder: _buildFooter),
        child: _buildBody());
  }

// FIXME footer not showing
  Widget _buildFooter(BuildContext context, LoadStatus? mode) {
    return const Align(
        alignment: Alignment.bottomCenter,
        child: RefreshProgressIndicator(
          backgroundColor: ThemeColor.primary,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ));
  }

  Widget _buildBody() {
    return Observer(builder: (context) {
      if (controller.status.isError) {
        return showUnexpectedError(controller.status.errorMessage);
      } else if (controller.status.isLoading && controller.state.isEmpty) {
        return FixedSpace.empty;
      } else {
        return buildContent(context, controller.state);
      }
    });
  }

  Widget buildContent(BuildContext context, List<E> data);
}
