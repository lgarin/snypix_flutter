import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snypix_flutter/app/data/models/media_model.dart';
import 'package:snypix_flutter/app/data/models/paging_model.dart';
import 'package:snypix_flutter/app/data/providers/media_query_provider.dart';
import 'package:snypix_flutter/app/data/services/access_token_service.dart';

class MediaQueryService extends GetxService {
  MediaQueryProvider get _queryApi => Get.find<MediaQueryProvider>();
  AccessTokenService get _tokenService => Get.find<AccessTokenService>();

  Future<MediaModelPage> listMedia(
      String? category, String keywords, PagingParameter paging,
      {LatLngBounds? bounds}) async {
    final accessToken = await _tokenService.obtainAccessToken();
    return await _queryApi.listMedia(
        category: category,
        keywords: keywords.isEmpty ? null : keywords,
        bounds: bounds,
        paging: paging,
        accessToken: accessToken);
  }

  Future<List<String>> suggestTags(String term, int maxHitCount) async {
    if (term.length < 3) {
      return <String>[];
    }
    final accessToken = await _tokenService.obtainAccessToken();
    return await _queryApi.suggestTags(
        term: term, maxHitCount: maxHitCount, accessToken: accessToken);
  }
}
