import 'package:get/get_connect.dart';
import 'package:snypix_flutter/core/values/strings.dart';

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
