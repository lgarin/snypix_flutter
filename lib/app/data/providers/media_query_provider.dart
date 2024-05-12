import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:snypix_flutter/app/data/models/media_model.dart';
import 'package:snypix_flutter/app/data/models/paging_model.dart';
import 'package:snypix_flutter/core/data/providers/http_provider.dart';
import 'package:snypix_flutter/core/values/consts.dart';

class MediaQueryProvider extends HttpProvider {
  static String toThumbnailUrl(String mediaUri) =>
      '${BackendConfig.baseUrl}/file/thumbnail/$mediaUri';

  static String toPreviewUrl(String mediaUri) =>
      '${BackendConfig.baseUrl}/file/preview/$mediaUri';

  static String toFullUrl(String mediaUri) =>
      '${BackendConfig.baseUrl}/file/download/$mediaUri';

  static String toVideoUrl(String mediaUri) =>
      '${BackendConfig.baseUrl}/file/stream/$mediaUri';

  static String toSmallAvatarUrl(String imageUri) =>
      '${BackendConfig.baseUrl}/file/avatar/small/$imageUri';

  static String toLargeAvatarUrl(String imageUri) =>
      '${BackendConfig.baseUrl}/file/avatar/large/$imageUri';

  static String toAvatarUrl(String imageUri, bool small) =>
      small ? toSmallAvatarUrl(imageUri) : toLargeAvatarUrl(imageUri);

  Future<MediaModelPage> listMedia(
      {String? creator,
      String? category,
      String? keywords,
      LatLngBounds? bounds,
      required PagingParameter paging,
      required String accessToken}) async {
    final creatorParameter = creator != null ? '&creator=$creator' : '';
    final categoryParameter = category != null ? '&category=$category' : '';
    final keywordsParameter = keywords != null ? '&keywords=$keywords' : '';
    final boundsParameter = bounds != null
        ? '&minLongitude=${bounds.southwest.longitude}&maxLongitude=${bounds.northeast.longitude}&minLatitude=${bounds.southwest.latitude}&maxLatitude=${bounds.northeast.latitude}'
        : '';
    final timestampParameter =
        paging.timestamp != null ? '&pagingTimestamp=${paging.timestamp}' : '';
    final uri =
        '/media/search?pageNumber=${paging.pageNumber}&pageSize=${paging.pageSize}$timestampParameter$creatorParameter$categoryParameter$keywordsParameter$boundsParameter';
    final response =
        await get(uri, headers: buildHeader(accessToken: accessToken));
    if (response.isOk) {
      return MediaModelPage.fromJson(response.body);
    }
    throw extractErrorMessage(response);
  }

  Future<List<String>> suggestTags(
      {required String term,
      required int maxHitCount,
      required String accessToken}) async {
    final uri = '/media/suggestTags?term=$term&maxHitCount=$maxHitCount';
    final response =
        await get(uri, headers: buildHeader(accessToken: accessToken));
    if (response.isOk) {
      return List<String>.from(response.body);
    }
    throw extractErrorMessage(response);
  }
}
