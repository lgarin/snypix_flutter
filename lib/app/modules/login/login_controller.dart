import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/models/credential_model.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();

  final _username = ''.obs;
  final _password = ''.obs;
  final _storeCredential = false.obs;
  final _ready = false.obs;

  LoginController();

  LoginController.fromCredential(CredentialModel credential) {
    _username.value = credential.username;
    _password.value = credential.password;
    _storeCredential.value = hasUsernameInput() && hasPasswordInput();
  }

  String get username => _username.value;
  String get password => _password.value;
  bool get storeCredential => _storeCredential.value;

  void setUsername(String? newUsername) => _username.value = newUsername ?? '';
  void setPassword(String? newPassword) => _password.value = newPassword ?? '';
  void setStoreCredential(bool? newValue) =>
      _storeCredential.value = newValue ?? false;

  bool hasInput() => hasUsernameInput() || hasPasswordInput();

  bool hasUsernameInput() => _username.value != '';

  bool hasPasswordInput() => _password.value != '';

  bool isDefined() => hasUsernameInput() && hasPasswordInput();

  CredentialModel toCredential() => CredentialModel(username, password);

  bool get isReady => _ready.value;

  @override
  void onReady() {
    // TODO load saved credentials
    _ready.value = true;
  }

  void onLogin() {
    // TODO perform login
  }

  void onRegister() {
    // TODO navigate to register page
  }
}
