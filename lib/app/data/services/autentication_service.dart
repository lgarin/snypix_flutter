import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/models/credential_model.dart';
import 'package:snypix_flutter/app/data/models/login_response_model.dart';
import 'package:snypix_flutter/app/data/models/user_profile_model.dart';
import 'package:snypix_flutter/app/data/providers/authentication_provider.dart';
import 'package:snypix_flutter/app/data/services/credential_store_service.dart';
import 'package:snypix_flutter/app/data/services/user_profile_service.dart';

class _AuthToken {
  static const refreshTokenDelta = 10000;

  final String accessToken;
  final String refreshToken;
  final int _expiration;

  _AuthToken(LoginTokenModel login)
      : accessToken = login.accessToken,
        refreshToken = login.refreshToken,
        _expiration = login.expiration;

  bool isExpired(DateTime now) {
    return _expiration - refreshTokenDelta < now.millisecondsSinceEpoch;
  }
}

class AuthenticationService extends GetxService {
  AuthenticationProvider get _authApi => Get.find<AuthenticationProvider>();
  CredentialStoreService get _credentialStore =>
      Get.find<CredentialStoreService>();
  UserProfileService get _userProfile => Get.find<UserProfileService>();

  _AuthToken? _token;

  void _initToken(LoginTokenModel? response) {
    _token = response != null ? _AuthToken(response) : null;
  }

  Future<CredentialModel> loadInitialCredentials() async {
    return _credentialStore.load();
  }

  Future<UserProfileModel> authenticate(
      CredentialModel credential, bool storeCredential) async {
    if (storeCredential) {
      await _credentialStore.store(credential);
    }
    var login = await _authApi.loginUser(credential);
    _initToken(login);

    final profile = UserProfileModel.fromLoginResponse(login);
    _userProfile.notifyChange(profile);
    return profile;
  }

  Future<String?> getOrRenewAccessToken() async {
    if (_token != null && _token!.isExpired(DateTime.timestamp())) {
      final response = await _authApi.renewLogin(_token!.refreshToken);
      _initToken(response);
    }
    return _token?.accessToken;
  }

  Future<void> logout() async {
    final accessToken = _token?.accessToken;
    if (accessToken is String) {
      try {
        await _authApi.logout(accessToken);
      } catch (e) {
        // ignore
      }
    }
    _token = null;
    _userProfile.notifyChange(UserProfileModel.anonym());
  }

  Future<void> signOut() async {
    await logout();
    await _credentialStore.clear();
  }
}
