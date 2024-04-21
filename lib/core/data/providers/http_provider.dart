import 'package:get/get.dart';
import 'package:snypix_flutter/core/values/consts.dart';
import 'package:snypix_flutter/core/values/strings.dart';

abstract class HttpProvider extends GetConnect {
  final jsonMediaType = 'application/json; charset=utf-8';
  final textMediaType = 'text/plain; charset=utf-8';

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = BackendConfig.baseUrl;
  }

  Map<String, String> buildHeader({String? contentType, String? accessToken}) {
    return <String, String>{
      'Accept': jsonMediaType,
      if (contentType != null) 'Content-type': contentType,
      if (accessToken != null) 'Authorization': accessToken,
    };
  }

  String extractErrorMessage(Response response) {
    if (response.unauthorized) {
      return ErrorMessage.badCredentials;
    } else if (response.status.connectionError) {
      return ErrorMessage.noConnection;
    }

    return response.bodyString ??
        response.statusText ??
        ErrorMessage.unknownError; // TODO better error handling
  }
}
