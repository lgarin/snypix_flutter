import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/models/credential_model.dart';
import 'package:snypix_flutter/app/data/models/login_model.dart';
import 'package:snypix_flutter/app/data/models/userprofile_model.dart';
import 'package:snypix_flutter/app/data/providers/authentication_provider.dart';
import 'package:snypix_flutter/app/data/services/credential_store_service.dart';

class _AuthToken {
  static const refreshTokenDelta = 10000;

  final String accessToken;
  final String refreshToken;
  final int _expiration;

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

  void _initToken(LoginTokenResponse? response) {
    _token = response != null ? _AuthToken(response) : null;
  }

  Future<CredentialModel> loadInitialCredentials() async {
    return _credentialStore.load();
  }

  Future<UserProfile> authenticate(
      CredentialModel credential, bool storeCredential) async {
    if (storeCredential) {
      await _credentialStore.store(credential);
    } else {
      await _credentialStore.clear();
    }
    var login = await _authApi.loginUser(credential);
    _initToken(login);

    final profile = UserProfile.fromLogin(login);
    //_profileController.add(profile); // TODO notify profile change
    return profile;
  }

  Future<String?> getOrRenewAccessToken() async {
    if (_token != null && _token!.expired) {
      final response = await _authApi.renewLogin(_token!.refreshToken);
      _initToken(response);
    }
    return _token?.accessToken;
  }

  Future<UserProfile> currentUser() async {
    UserProfile? profile;
    try {
      final accessToken = await getOrRenewAccessToken();
      if (accessToken is String) {
        profile = await _authApi.currentUser(accessToken);
      }
    } catch (e) {
      // no server connection
      print(e.toString());
    }
    if (profile != null) {
      //_profileController.add(profile); // TODO notify profile change
    }
    return profile ?? UserProfile.anonym();
  }

  Future<String?> obtainAccessToken() async {
    final token = await getOrRenewAccessToken();
    if (token == null) {
      //await _navigation.pushPage(AppRoute.Login);
      // TODO navigate to login
    }
    return obtainAccessToken();
  }

  Future<void> logout() async {
    final accessToken = _token?.accessToken;
    if (accessToken is String) {
      try {
        await _authApi.logout(accessToken);
      } catch (e) {
        // ignore
        print(e.toString());
      }
    }
    _token = null;
    //_profileController.add(UserProfile.anonym()); // TODO notify profile change
  }

  Future<void> signOut() async {
    await logout();
    await _credentialStore.clear();
  }
}
