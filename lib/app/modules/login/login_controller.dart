import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/models/credential_model.dart';
import 'package:snypix_flutter/app/data/models/user_profile_model.dart';
import 'package:snypix_flutter/app/data/services/autentication_service.dart';
import 'package:snypix_flutter/app/routes/app_routes.dart';
import 'package:snypix_flutter/core/widgets/simple_dialogs.dart';
import 'package:snypix_flutter/core/values/strings.dart';

class LoginController extends GetxController with StateMixin<CredentialModel> {
  AuthenticationService get _authService => Get.find<AuthenticationService>();
  final loginFormKey = GlobalKey<FormState>();

  var _credential = CredentialModel.empty();
  final _storeCredential = false.obs;

  LoginController();

  LoginController.fromCredential(CredentialModel credential) {
    _credential = credential;
    _storeCredential.value = hasUsernameInput() && hasPasswordInput();
  }

  String get username => _credential.username;
  String get password => _credential.password;
  bool get storeCredential => _storeCredential.value;

  void setUsername(String? newUsername) =>
      _credential = CredentialModel(newUsername ?? '', password);
  void setPassword(String? newPassword) =>
      _credential = CredentialModel(username, newPassword ?? '');
  void setStoreCredential(bool? newValue) =>
      _storeCredential.value = newValue ?? false;

  bool hasInput() => hasUsernameInput() || hasPasswordInput();

  bool hasUsernameInput() => username != '';

  bool hasPasswordInput() => password != '';

  // TODO state should not be overriden
  @override
  CredentialModel get state => _credential;

  @override
  void onReady() async {
    change(GetStatus.loading());
    try {
      _credential = await _authService.loadInitialCredentials();
      change(GetStatus.success(_credential));
    } catch (e) {
      change(GetStatus.error(e.toString()));
    }

    if (!_credential.isEmpty) {
      await _performLogin();
    }
  }

  void onLogin() async {
    final form = loginFormKey.currentState!;
    if (form.validate()) {
      form.save();
      await _performLogin();
    }
  }

  Future<void> _performLogin() async {
    change(GetStatus.loading());
    final userProfile =
        await _authenticateUser(_credential, _storeCredential.value);
    if (userProfile != null) {
      await Get.offNamed(AppRoutes.home);
    } else {
      change(GetStatus.success(_credential));
    }
  }

  Future<UserProfileModel?> _authenticateUser(
      CredentialModel credential, bool storeCredential) async {
    try {
      return await _authService.authenticate(_credential, storeCredential);
    } catch (e) {
      await showMessageDialog(ErrorMessage.loginFailed, e.toString());
      return null;
    }
  }

  void onRegister() {
    // TODO navigate to register page
  }
}
