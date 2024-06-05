import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class TestController extends GetxController with StateMixin<int> {
  static const delay = Duration(seconds: 2);

  int _itemCount = 0;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    change(GetStatus.loading());
    await Future.delayed(delay);
    _itemCount = 20;
    change(GetStatus.success(_itemCount));
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    change(GetStatus.loading());
    await Future.delayed(delay);
    _itemCount += 20;
    change(GetStatus.success(_itemCount));
    refreshController.loadComplete();
  }
}
