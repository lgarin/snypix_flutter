import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/providers/authentication_provider.dart';
import 'package:snypix_flutter/app/data/providers/media_query_provider.dart';
import 'package:snypix_flutter/app/data/providers/userprofile_provider.dart';
import 'package:snypix_flutter/app/data/services/access_token_service.dart';
import 'package:snypix_flutter/app/data/services/autentication_service.dart';
import 'package:snypix_flutter/app/data/services/credential_store_service.dart';
import 'package:snypix_flutter/app/data/services/media_query_service.dart';
import 'package:snypix_flutter/app/data/services/user_profile_service.dart';
import 'package:snypix_flutter/app/modules/home/gallery_controller.dart';
import 'package:snypix_flutter/app/modules/home/home_controller.dart';
import 'package:snypix_flutter/app/modules/login/login_controller.dart';
import 'package:snypix_flutter/core/values/strings.dart';

abstract class AppBinds {
  static final List<Bind> global = [
    Bind.lazyPut(AuthenticationProvider.new),
    Bind.lazyPut(MediaQueryProvider.new),
    Bind.lazyPut(UserProfileProvider.new),
    Bind.lazyPut(CredentialStoreService.new),
    Bind.lazyPut(AuthenticationService.new),
    Bind.lazyPut(AccessTokenService.new),
    Bind.lazyPut(UserProfileService.new),
    Bind.lazyPut(MediaQueryService.new),
  ];

  static final List<Bind> login = [
    Bind.lazyPut(LoginController.new),
  ];

  static final List<Bind> home = [
    Bind.lazyPut(HomeController.new),
    ...ExtendedMediaCategory.tokens.map(
        (token) => Bind.lazyPut(() => GalleryController(token), tag: token)),
  ];
}
