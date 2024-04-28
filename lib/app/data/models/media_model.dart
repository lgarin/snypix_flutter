import 'package:snypix_flutter/app/data/models/paging_model.dart';

enum ApprovalModifier {
  like('LIKE'),
  dislike('DISLIKE');

  final String name;

  const ApprovalModifier(this.name);

// TODO cleanup
  static ApprovalModifier fromJson(String name) =>
      values.firstWhere((element) => element.name == name,
          orElse: () => throw ArgumentError('Unknown ApprovalModifier: $name'));
}

enum MediaFormat {
  mediaJpg('MEDIA_JPG'),
  mediaMov('MEDIA_MOV'),
  mediaMp4('MEDIA_MP4'),
  previewJpg('PREVIEW_JPG'),
  previewMp4('PREVIEW_MP4'),
  thumbnailJpg('THUMBNAIL_JPG');

  final String name;

  const MediaFormat(this.name);

  // TODO cleanup
  static MediaFormat fromJson(String name) =>
      values.firstWhere((element) => element.name == name,
          orElse: () => throw ArgumentError('Unknown MediaFormat: $name'));
}

class MediaModel {
  final String title;
  final String mediaUri;
  final int hitCount;
  final int likeCount;
  final int dislikeCount;
  final int commentCount;
  final double? latitude;
  final double? longitude;
  final MediaFormat previewFormat;
  final MediaFormat fileFormat;
  final int? feeling;

  MediaModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        mediaUri = json['mediaUri'],
        hitCount = json['hitCount'],
        likeCount = json['likeCount'],
        dislikeCount = json['dislikeCount'],
        commentCount = json['commentCount'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        previewFormat = MediaFormat.fromJson(json['previewFormat']),
        fileFormat = MediaFormat.fromJson(json['fileFormat']),
        feeling = json['feeling'];

  bool get hasVideoPreview => previewFormat == MediaFormat.previewMp4;
  bool get isVideo =>
      fileFormat == MediaFormat.mediaMov || fileFormat == MediaFormat.mediaMp4;

  static List<MediaModel> fromJsonList(List<dynamic> json) {
    return json.map((e) => MediaModel.fromJson(e)).toList();
  }
}

class MediaModelPage extends ResultPage<MediaModel> {
  MediaModelPage.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, MediaModel.fromJsonList);
}
