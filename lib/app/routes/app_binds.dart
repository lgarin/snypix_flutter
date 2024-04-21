import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/providers/authentication_provider.dart';
import 'package:snypix_flutter/app/data/providers/userprofile_provider.dart';
import 'package:snypix_flutter/app/data/services/autentication_service.dart';
import 'package:snypix_flutter/app/data/services/credential_store_service.dart';
import 'package:snypix_flutter/app/data/services/user_profile_service.dart';
import 'package:snypix_flutter/app/modules/login/login_controller.dart';

abstract class AppBinds {
  static final List<Bind> global = [
    Bind.lazyPut(CredentialStoreService.new),
    Bind.lazyPut(AuthenticationProvider.new),
    Bind.lazyPut(UserProfileProvider.new),
    Bind.lazyPut(AuthenticationService.new),
    Bind.lazyPut(UserProfileService.new),
  ];

  static final List<Bind> login = [
    Bind.lazyPut(LoginController.new),
  ];
}
