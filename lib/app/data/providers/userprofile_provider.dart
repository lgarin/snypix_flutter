import 'package:snypix_flutter/app/data/models/user_profile_model.dart';
import 'package:snypix_flutter/core/data/providers/http_provider.dart';

class UserProfileProvider extends HttpProvider {
  Future<UserProfileModel?> currentUser(String accessToken) async {
    const uri = '/user/current';
    final response =
        await get(uri, headers: buildHeader(accessToken: accessToken));
    if (response.isOk) {
      return UserProfileModel.fromJson(response.body);
    } else if (response.unauthorized) {
      return null;
    }
    throw extractErrorMessage(response);
  }
}
