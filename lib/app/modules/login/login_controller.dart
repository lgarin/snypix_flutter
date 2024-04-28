import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/models/credential_model.dart';
import 'package:snypix_flutter/app/data/services/autentication_service.dart';
import 'package:snypix_flutter/app/routes/app_routes.dart';
import 'package:snypix_flutter/core/widgets/simple_dialogs.dart';
import 'package:snypix_flutter/core/values/strings.dart';

class LoginController extends GetxController with StateMixin<CredentialModel> {
  AuthenticationService get _authService => Get.find<AuthenticationService>();
  final loginFormKey = GlobalKey<FormState>();

  final _storeCredential = false.obs;

  LoginController();

  String get username => value.username;
  String get password => value.password;
  bool get storeCredential => _storeCredential.value;

  void setUsername(String? newUsername) =>
      value = CredentialModel(newUsername ?? '', password);
  void setPassword(String? newPassword) =>
      value = CredentialModel(username, newPassword ?? '');
  void setStoreCredential(bool? newValue) =>
      _storeCredential.value = newValue ?? false;

  bool hasInput() => hasUsernameInput() || hasPasswordInput();

  bool hasUsernameInput() => username != '';

  bool hasPasswordInput() => password != '';

  @override
  void onReady() async {
    change(GetStatus.loading());
    try {
      final credential = await _authService.loadInitialCredentials();
      change(GetStatus.success(credential));
    } catch (e) {
      change(GetStatus.error(e.toString()));
    }

    if (!value.isEmpty) {
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
    try {
      await _authService.authenticate(value, storeCredential);
      await Get.offNamed(AppRoutes.home);
    } catch (e) {
      await showMessageDialog(ErrorMessage.loginFailed, e.toString());
    }
    change(GetStatus.success(value));
  }

  void onRegister() {
    // TODO navigate to register page
  }
}
