import 'package:snypix_flutter/app/data/models/userprofile_model.dart';

class LoginTokenResponse {
  final String accessToken;
  final String refreshToken;
  final int expiration;

  LoginTokenResponse.fromJson(Map<String, dynamic> json)
      : accessToken = json['accessToken'],
        refreshToken = json['refreshToken'],
        expiration = json['expiration'];
}

class LoginResponse extends LoginTokenResponse {
  final String userId;
  final String username;
  final String? email;
  final DateTime? createdTimestamp;
  final String? firstname;
  final String? lastname;
  final String? country;
  final String? biography;
  final String? birthdate;
  final String? gender;
  final String? imageUri;
  final UserStatistic? statistic;
  final UserPrivacy? privacy;

  LoginResponse.fromJson(Map<String, dynamic> json)
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
            ? UserStatistic.fromJson(json['statistic'])
            : null,
        privacy = json['privacy'] != null
            ? UserPrivacy.fromJson(json['privacy'])
            : null,
        super.fromJson(json);
}
