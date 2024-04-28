import 'package:snypix_flutter/app/data/models/paging_model.dart';
import 'package:snypix_flutter/core/data/models/java_enum.dart';

enum ApprovalModifier implements JavaEnum {
  like('LIKE'),
  dislike('DISLIKE');

  @override
  final String javaName;

  const ApprovalModifier(this.javaName);

  static ApprovalModifier fromJson(String name) => values.getByJavaName(name);
}

enum MediaFormat implements JavaEnum {
  mediaJpg('MEDIA_JPG'),
  mediaMov('MEDIA_MOV'),
  mediaMp4('MEDIA_MP4'),
  previewJpg('PREVIEW_JPG'),
  previewMp4('PREVIEW_MP4'),
  thumbnailJpg('THUMBNAIL_JPG');

  @override
  final String javaName;

  const MediaFormat(this.javaName);

  static MediaFormat fromJson(String name) => values.getByJavaName(name);
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
