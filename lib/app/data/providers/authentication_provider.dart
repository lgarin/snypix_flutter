import 'dart:convert';

import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:snypix_flutter/app/data/models/credential_model.dart';
import 'package:snypix_flutter/app/data/models/login_response_model.dart';
import 'package:snypix_flutter/core/data/providers/http_provider.dart';

class AuthenticationProvider extends HttpProvider {
  Future<LoginResponseModel> loginUser(CredentialModel credential) async {
    const uri = '/user/login';
    final response = await post(uri, jsonEncode(credential),
        headers: buildHeader(contentType: jsonMediaType));
    if (response.isOk) {
      return LoginResponseModel.fromJson(response.body);
    }
    throw extractErrorMessage(response);
  }

  Future<LoginTokenModel?> renewLogin(String refreshToken) async {
    const uri = '/user/renewLogin';
    final response = await post(uri, refreshToken,
        headers: buildHeader(contentType: textMediaType));
    if (response.isOk) {
      return LoginTokenModel.fromJson(response.body);
    } else if (response.unauthorized) {
      return null;
    }
    throw extractErrorMessage(response);
  }

  Future<void> logout(String accessToken) async {
    const uri = '/user/logout';
    final response =
        await post(uri, null, headers: buildHeader(accessToken: accessToken));
    if (response.statusCode == HttpStatus.noContent) {
      return;
    }
    throw extractErrorMessage(response);
  }
}
