import 'package:get/get.dart';
import 'package:snypix_flutter/app/data/models/user_profile_model.dart';
import 'package:snypix_flutter/app/data/providers/userprofile_provider.dart';
import 'package:snypix_flutter/app/data/services/autentication_service.dart';

class UserProfileService extends GetxService {
  UserProfileProvider get _profileApi => Get.find<UserProfileProvider>();
  AuthenticationService get _authService => Get.find<AuthenticationService>();

  final _profile = UserProfileModel.anonym().obs;

  UserProfileModel get current => _profile.value;

  void notifyChange(UserProfileModel profile) {
    _profile.value = profile;
  }

  Future<void> reloadUserProfile() async {
    UserProfileModel? profile;
    try {
      final accessToken = await _authService.getOrRenewAccessToken();
      if (accessToken is String) {
        profile = await _profileApi.currentUser(accessToken);
      }
    } catch (e) {
      // ignore
    }
    notifyChange(profile ?? UserProfileModel.anonym());
  }
}
