import 'package:snypix_flutter/app/data/models/login_response_model.dart';

class UserStatisticModel {
  final int hitCount;
  final int likeCount;
  final int dislikeCount;
  final int followerCount;
  final int pictureCount;
  final int videoCount;
  final int commentCount;

  UserStatisticModel.fromJson(Map<String, dynamic> json)
      : hitCount = json['hitCount'],
        likeCount = json['likeCount'],
        dislikeCount = json['dislikeCount'],
        followerCount = json['followerCount'],
        pictureCount = json['pictureCount'],
        videoCount = json['videoCount'],
        commentCount = json['commentCount'];

  int get mediaCount => pictureCount + videoCount;
}

enum LocationPrivacy {
  blur('BLUR'),
  mask('MASK');

  static const Map<String, LocationPrivacy> _locationPrivacyMap = {
    'BLUR': LocationPrivacy.blur,
    'MASK': LocationPrivacy.mask,
  };

  final String name;

  const LocationPrivacy(this.name);

  static LocationPrivacy? fromJson(String name) => _locationPrivacyMap[name];
}

class UserPrivacyModel {
  final bool birthdateMasked;
  final bool genderMasked;
  final bool nameMasked;
  final LocationPrivacy? location;
  final bool feelingMasked;

  UserPrivacyModel(
      {required this.birthdateMasked,
      required this.genderMasked,
      required this.nameMasked,
      this.location,
      required this.feelingMasked});

  UserPrivacyModel.fromJson(Map<String, dynamic> json)
      : birthdateMasked = json['birthdateMasked'] ?? false,
        genderMasked = json['genderMasked'] ?? false,
        nameMasked = json['nameMasked'] ?? false,
        location = json['location'] != null
            ? LocationPrivacy.fromJson(json['location'])
            : null,
        feelingMasked = json['feelingMasked'] ?? false;

  Map<String, dynamic> toJson() => {
        'nameMasked': nameMasked,
        'genderMasked': genderMasked,
        'birthdateMasked': birthdateMasked,
        'location': location?.name,
        'feelingMasked': feelingMasked,
      };
}

class UserProfileModel {
  final String? userId;
  final String? username;
  final bool? online;
  final String? email;
  final DateTime? createdTimestamp;
  final String? firstname;
  final String? lastname;
  final String? country;
  final String? imageUri;
  final String? birthdate;
  final String? biography;
  final String? gender;
  final UserStatisticModel? statistic;
  final UserPrivacyModel? privacy;
  final DateTime? followedSince;

  UserProfileModel.fromLoginResponse(LoginResponseModel login)
      : userId = login.userId,
        username = login.username,
        online = true,
        email = login.email,
        createdTimestamp = login.createdTimestamp,
        firstname = login.firstname,
        lastname = login.lastname,
        imageUri = login.imageUri,
        country = login.country,
        birthdate = login.birthdate,
        biography = login.biography,
        gender = login.gender,
        statistic = login.statistic,
        privacy = login.privacy,
        followedSince = null;

  UserProfileModel.anonym()
      : userId = null,
        username = null,
        online = false,
        email = null,
        createdTimestamp = null,
        firstname = null,
        lastname = null,
        country = null,
        imageUri = null,
        birthdate = null,
        biography = null,
        gender = null,
        statistic = null,
        privacy = null,
        followedSince = null;

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : userId = json['id'],
        username = json['username'],
        online = json['online'],
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
        statistic = UserStatisticModel.fromJson(json['statistic']),
        privacy = json['privacy'] != null
            ? UserPrivacyModel.fromJson(json['privacy'])
            : null,
        followedSince = json['followedSince'] != null
            ? DateTime.fromMillisecondsSinceEpoch(json['followedSince'])
            : null;

  static List<UserProfileModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => UserProfileModel.fromJson(e)).toList();
  }

  bool get anonym => userId == null;

  bool get followed => followedSince != null;

  bool get incomplete =>
      (firstname?.isEmpty ?? true) ||
      (lastname?.isEmpty ?? true) ||
      country == null ||
      (biography?.isEmpty ?? true) ||
      birthdate == null ||
      gender == null ||
      imageUri == null;

  bool same(UserProfileModel other) =>
      userId == other.userId &&
      username == other.username &&
      email == other.email &&
      firstname == other.firstname &&
      lastname == other.lastname &&
      country == other.country &&
      imageUri == other.imageUri &&
      birthdate == other.birthdate &&
      biography == other.biography &&
      gender == other.gender;
}
