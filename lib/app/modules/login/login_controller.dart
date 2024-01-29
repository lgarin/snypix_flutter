import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/models/credential_model.dart';
import 'package:snypix_flutter/app/data/services/credential_store_service.dart';

class LoginController extends GetxController with StateMixin<CredentialModel> {
  final credentialStore = Get.find<CredentialStoreService>();
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

  bool isDefined() => hasUsernameInput() && hasPasswordInput();

  @override
  CredentialModel get state => _credential;

  @override
  void onReady() async {
    GetStatus.loading();
    try {
      _credential = await credentialStore.load();
      change(GetStatus.success(_credential));
    } catch (e) {
      change(GetStatus.error(e.toString()));
    }
  }

  void onLogin() async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      if (storeCredential) {
        await credentialStore.store(_credential);
      } else {
        await credentialStore.clear();
      }
      // TODO perform login
    }
  }

  void onRegister() {
    // TODO navigate to register page
  }
}
