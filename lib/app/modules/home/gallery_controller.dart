import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/models/media_model.dart';
import 'package:snypix_flutter/app/data/models/paging_model.dart';
import 'package:snypix_flutter/app/data/services/media_query_service.dart';
import 'package:snypix_flutter/app/modules/content/paged_controller.dart';

class GalleryController extends PagedController<MediaModel> {
  MediaQueryService get _queryService => Get.find<MediaQueryService>();

  final String? _categoryToken;

  GalleryController(this._categoryToken);

  @override
  Future<ResultPage<MediaModel>> loadNextPage(
      PagingParameter parameter, String searchKeyword) {
    return _queryService.listMedia(_categoryToken, searchKeyword, parameter);
  }

  void onGridTileSelection(MediaModel media) async {
    /*
    final newValue = await Get.toNamed(AppRoute.RemoteMediaDetail, arguments: media);
    if (newValue != null) {
      replaceItem((item) => item.mediaUri == media.mediaUri, newValue);
    }
    */
  }
}
