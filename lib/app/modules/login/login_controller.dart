import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/models/credential_model.dart';
import 'package:snypix_flutter/app/data/models/userprofile_model.dart';
import 'package:snypix_flutter/app/data/services/autentication_service.dart';
import 'package:snypix_flutter/app/widgets/simple_dialog.dart';
import 'package:snypix_flutter/core/values/strings.dart';

class LoginController extends GetxController with StateMixin<CredentialModel> {
  final authenticationService = Get.find<AuthenticationService>();
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
    change(GetStatus.loading());
    try {
      _credential = await authenticationService.loadInitialCredentials();
      change(GetStatus.success(_credential));
    } catch (e) {
      change(GetStatus.error(e.toString()));
    }
  }

  void onLogin() async {
    final form = loginFormKey.currentState!;
    if (form.validate()) {
      form.save();
      _authenticateUser(_credential, _storeCredential.value);
    }
  }

  Future<UserProfile?> _authenticateUser(
      CredentialModel credential, bool storeCredential) async {
    try {
      final userProfile = await authenticationService.authenticate(
          _credential, storeCredential);
      _showNextPage(userProfile);
      return userProfile;
    } catch (e) {
      showMessageDialog(loginFailed, e.toString());
      return null;
    }
  }

  void _showNextPage(UserProfile userProfile) {
    // TODO navigate to next page
  }

  void onRegister() {
    // TODO navigate to register page
  }
}
