import 'dart:convert';

import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:snypix_flutter/app/data/models/credential_model.dart';
import 'package:snypix_flutter/app/data/models/login_response_model.dart';
import 'package:snypix_flutter/core/data/providers/http_provider.dart';

class AuthenticationProvider extends HttpProvider {
  Future<LoginResponseModel> loginUser(CredentialModel credential) async {
    final response = await post('/user/login', jsonEncode(credential),
        headers: buildHeader(contentType: jsonMediaType));
    if (response.isOk) {
      return LoginResponseModel.fromJson(response.body);
    }
    throw extractErrorMessage(response);
  }

  Future<LoginTokenModel?> renewLogin(String refreshToken) async {
    final response = await post('/user/renewLogin', refreshToken,
        headers: buildHeader(contentType: textMediaType));
    if (response.isOk) {
      return LoginTokenModel.fromJson(response.body);
    } else if (response.unauthorized) {
      return null;
    }
    throw extractErrorMessage(response);
  }

  Future<void> logout(String accessToken) async {
    final response = await post('/user/logout', null,
        headers: buildHeader(accessToken: accessToken));
    if (response.statusCode == HttpStatus.noContent) {
      return;
    }
    throw extractErrorMessage(response);
  }
}
