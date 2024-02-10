import 'dart:convert';

import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/models/credential_model.dart';
import 'package:snypix_flutter/app/data/models/login_model.dart';
import 'package:snypix_flutter/app/data/models/userprofile_model.dart';
import 'package:snypix_flutter/core/values/consts.dart';
import 'package:snypix_flutter/core/values/strings.dart';

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
    final response = await post('/user/login', credential,
        headers: _buildHeader(contentType: jsonMediaType));
    if (response.isOk) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else if (response.unauthorized) {
      throw badCredentials;
    }
    throw response.bodyString ?? unknownError; // TODO better error handling
  }

  Future<LoginTokenResponse?> renewLogin(String refreshToken) async {
    final response = await post('/user/renewLogin', refreshToken,
        headers: _buildHeader(contentType: jsonMediaType));
    if (response.isOk) {
      return LoginTokenResponse.fromJson(jsonDecode(response.body));
    } else if (response.unauthorized) {
      return Future.value(null);
    }
    throw response.bodyString ?? unknownError; // TODO better error handling
  }

  Future<UserProfile?> currentUser(String? accessToken) async {
    final response = await get('/user/current',
        headers: _buildHeader(accessToken: accessToken));
    if (response.isOk) {
      return UserProfile.fromJson(jsonDecode(response.body));
    } else if (response.unauthorized) {
      return null;
    }
    throw response.bodyString ?? unknownError; // TODO better error handling
  }

  Future<void> logout(String accessToken) async {
    final response = await post('/user/logout', null,
        headers: _buildHeader(accessToken: accessToken));
    if (response.statusCode == 204) {
      return;
    }
    throw response.bodyString ?? unknownError; // TODO better error handling
  }
}
