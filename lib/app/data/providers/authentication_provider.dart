import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:snypix_flutter/app/data/models/credential_model.dart';
import 'package:snypix_flutter/app/data/models/login_model.dart';
import 'package:snypix_flutter/app/data/models/userprofile_model.dart';
import 'package:snypix_flutter/core/errors/http_error_handler.dart';
import 'package:snypix_flutter/core/values/consts.dart';

class AuthenticationProvider extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = baseServerUrl;
  }

  Map<String, String> _buildHeader({String? contentType, String? accessToken}) {
    final result = <String, String>{};
    result['Accept'] = jsonMediaType;
    if (contentType != null) {
      result['Content-type'] = contentType;
    }
    if (accessToken != null) {
      result['Authorization'] = accessToken;
    }
    return result;
  }

  Future<LoginResponse> loginUser(CredentialModel credential) async {
    final response = await post('/user/login', jsonEncode(credential),
        headers: _buildHeader(contentType: jsonMediaType));
    if (response.isOk) {
      return LoginResponse.fromJson(response.body);
    }
    throw extractErrorMessage(response);
  }

  Future<LoginTokenResponse?> renewLogin(String refreshToken) async {
    final response = await post('/user/renewLogin', refreshToken,
        headers: _buildHeader(contentType: textMediaType));
    if (response.isOk) {
      return LoginTokenResponse.fromJson(response.body);
    } else if (response.unauthorized) {
      return Future.value(null);
    }
    throw extractErrorMessage(response);
  }

  Future<UserProfile?> currentUser(String accessToken) async {
    final response = await get('/user/current',
        headers: _buildHeader(accessToken: accessToken));
    if (response.isOk) {
      return UserProfile.fromJson(response.body);
    } else if (response.unauthorized) {
      return null;
    }
    throw extractErrorMessage(response);
  }

  Future<void> logout(String accessToken) async {
    final response = await post('/user/logout', null,
        headers: _buildHeader(accessToken: accessToken));
    if (response.statusCode == HttpStatus.noContent) {
      return;
    }
    throw extractErrorMessage(response);
  }
}
