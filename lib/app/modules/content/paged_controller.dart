import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:snypix_flutter/app/data/models/paging_model.dart';
import 'package:snypix_flutter/app/modules/content/content_controller.dart';
import 'package:snypix_flutter/core/values/consts.dart';

abstract class PagedController<E> extends ContentController
    with StateMixin<List<E>> {
  var _nextPage = PagingParameter(pageSize: DataPaging.pageSize, pageNumber: 0);

  final _searchKeyword = ''.obs;
  final refreshController = RefreshController();

  String get searchKeyword => _searchKeyword.value;

  @override
  void onInit() {
    value = [];
    super.onInit();
  }

  @override
  void onClose() {
    refreshController.dispose();
    super.onClose();
  }

  Future<ResultPage<E>> loadNextPage(
      PagingParameter parameter, String searchKeyword);

  void refreshData(String searchKeyword) async {
    _searchKeyword.value = searchKeyword;
    await refreshController.requestRefresh();
  }

  void onRefresh() async {
    change(GetStatus.loading());
    try {
      _nextPage = PagingParameter(pageSize: DataPaging.pageSize, pageNumber: 0);
      final result = await loadNextPage(_nextPage, _searchKeyword.value);
      _updateState([], result);
      refreshController.refreshCompleted();
      if (_nextPage.pageSize == 0) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    } catch (e) {
      refreshController.refreshFailed();
      change(GetStatus.error(e.toString()));
    }
  }

// FIXME this method is not called
  void onLoading() async {
    change(GetStatus.loading());
    try {
      final result = await loadNextPage(_nextPage, _searchKeyword.value);
      _updateState(value, result);
      if (_nextPage.pageSize == 0) {
        refreshController.loadNoData();
      } else {
        refreshController.loadComplete();
      }
    } catch (e) {
      refreshController.loadFailed();
      change(GetStatus.error(e.toString()));
    }
  }

  void replaceItem(bool Function(E) test, E newValue) {
    final index = value.indexWhere(test);
    if (index >= 0) {
      value[index] = newValue;
    }
  }

  void _updateState(List<E> previousState, ResultPage<E> result) {
    _nextPage = result.nextPage ?? PagingParameter(pageSize: 0, pageNumber: -1);
    change(GetStatus.success([...previousState, ...result.content]));
  }
}
