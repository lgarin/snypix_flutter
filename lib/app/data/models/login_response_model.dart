import 'package:snypix_flutter/app/data/models/user_profile_model.dart';

class LoginTokenModel {
  final String accessToken;
  final String refreshToken;
  final int expiration;

  LoginTokenModel.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        refreshToken = json['refreshToken'],
        expiration = json['expiration'];
}

class LoginResponseModel extends LoginTokenModel {
  final String userId;
  final String username;
  final String? email;
  final DateTime? createdTimestamp;
  final String? firstname;
  final String? lastname;
  final String? country;
  final String? imageUri;
  final String? biography;
  final String? birthdate;
  final String? gender;
  final UserStatisticModel? statistic;
  final UserPrivacyModel? privacy;

  LoginResponseModel.fromJson(super.json)
      : userId = json['id'],
        username = json['username'],
        email = json['email'],
        createdTimestamp = json['createdTimestamp'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['createdTimestamp'])
            : null,
        firstname = json['firstname'],
        lastname = json['lastname'],
        country = json['country'],
        biography = json['biography'],
        birthdate = json['birthdate'],
        gender = json['gender'],
        imageUri = json['imageUri'],
        statistic = json['statistic'] != null
            ? UserStatisticModel.fromJson(json['statistic'])
            : null,
        privacy = json['privacy'] != null
            ? UserPrivacyModel.fromJson(json['privacy'])
            : null,
        super.fromJson();
}
