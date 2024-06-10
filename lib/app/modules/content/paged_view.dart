import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
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
  Widget build(BuildContext context) => Observer(builder: (context) {
        return SmartRefresher(
            key: PageStorageKey(tag),
            enablePullDown: true,
            enablePullUp: true,
            controller: controller.refreshController,
            onLoading: controller.onLoading,
            onRefresh: controller.onRefresh,
            header: const WaterDropMaterialHeader(),
            footer: CustomFooter(builder: _buildFooter),
            child: _buildBody(context));
      });

  Widget _buildFooter(BuildContext context, LoadStatus? mode) {
    if (mode != LoadStatus.loading) return FixedSpace.empty;
    return const Align(
        alignment: Alignment.bottomCenter,
        child: LinearProgressIndicator(
          backgroundColor: ThemeColor.primary,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          minHeight: FixedSpace.spacing,
        ));
  }

  Widget _buildBody(BuildContext context) {
    if (controller.status.isError) {
      return showUnexpectedError(controller.status.errorMessage);
    } else if (controller.status.isLoading && controller.state.isEmpty) {
      return FixedSpace.empty;
    } else {
      return buildContent(context, controller.state);
    }
  }

  Widget buildContent(BuildContext context, List<E> data);
}
