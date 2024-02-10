import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/models/credential_model.dart';
import 'package:snypix_flutter/app/data/models/login_model.dart';
import 'package:snypix_flutter/app/data/models/userprofile_model.dart';
import 'package:snypix_flutter/app/data/providers/authentication_provider.dart';
import 'package:snypix_flutter/app/data/services/credential_store_service.dart';

class _AuthToken {
  static const refreshTokenDelta = 10000;

  final accessToken;
  final refreshToken;
  final _expiration;

  _AuthToken(LoginTokenResponse login)
      : accessToken = login.accessToken,
        refreshToken = login.refreshToken,
        _expiration = login.expiration;

  bool get expired {
    return _expiration - refreshTokenDelta <
        DateTime.now().millisecondsSinceEpoch;
  }
}

class AuthenticationService extends GetxService {
  final _authApi = Get.find<AuthenticationProvider>();
  final _credentialStore = Get.find<CredentialStoreService>();

  _AuthToken? _token;

  void initToken(LoginTokenResponse? login) {
    _token = login != null ? _AuthToken(login) : null;
  }

  Future<UserProfile> authenticate(
      CredentialModel credential, bool storeCredential) async {
    if (storeCredential) {
      await _credentialStore.store(credential);
    } else {
      await _credentialStore.clear();
    }
    var login = await _authApi.loginUser(credential);
    initToken(login);

    final profile = UserProfile.fromLogin(login);
    //_profileController.add(profile);
    return profile;
  }

  Future<String?> getOrRenewAccessToken() async {
    if (_token != null && _token!.expired) {
      final login = await _authApi.renewLogin(_token!.refreshToken);
      initToken(login);
    }
    return _token?.accessToken;
  }

  Future<UserProfile> currentUser() async {
    UserProfile? profile;
    try {
      profile = await _authApi.currentUser(await getOrRenewAccessToken());
    } catch (e) {
      // no server connection
      profile = UserProfile.anonym();
    }
    if (profile != null) {
      //_profileController.add(profile);
    }
    return profile ?? UserProfile.anonym();
  }

  Future<String> obtainAccessToken() async {
    final token = await getOrRenewAccessToken();
    if (token == null) {
      //await _navigation.pushPage(AppRoute.Login);
      // TODO navigate to login
    }
    return _token?.accessToken;
  }

  Future<void> logout() async {
    try {
      await _authApi.logout(await getOrRenewAccessToken() ?? '');
    } catch (e) {
      // ignore
      print(e.toString());
    }
    _token = null;
    //_profileController.add(null);
  }

  Future<void> signOut() async {
    await logout();
    await _credentialStore.clear();
  }
}
