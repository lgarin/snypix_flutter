import 'package:flutter/material.dart';
import 'package:snypix_flutter/app/data/models/media_model.dart';
import 'package:snypix_flutter/app/data/providers/media_query_provider.dart';
import 'package:snypix_flutter/core/values/consts.dart';

typedef MediaSelectionCallback = void Function(MediaModel);

class MediaThumbnailWidget extends StatelessWidget {
  static const verticalSpace = SizedBox(height: 4);
  static const titleFont = TextStyle(fontSize: 14, color: Colors.black);
  static const normalFont = TextStyle(fontSize: 12, color: Colors.black);
  static const hitIcon =
      Icon(Icons.remove_red_eye, size: 14, color: Colors.black);
  static const likeIcon = Icon(Icons.thumb_up, size: 14, color: Colors.black);
  static const commentIcon = Icon(Icons.create, size: 14, color: Colors.black);
  static const backgroundColor = Colors.white30;

  final MediaModel media;
  final MediaSelectionCallback _onTapCallback;
  final MediaSelectionCallback _onLongPressCallback;

  static void _dummyCallback(MediaModel media) {}

  MediaThumbnailWidget(
      {required this.media,
      MediaSelectionCallback? onTapCallback,
      MediaSelectionCallback? onLongPressCallback})
      : _onTapCallback = onTapCallback ?? _dummyCallback,
        _onLongPressCallback = onLongPressCallback ?? _dummyCallback,
        super(key: ValueKey(media.mediaUri));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _onTapCallback(media),
        onLongPress: () => _onLongPressCallback(media),
        child: _buildTile(media));
  }

  GridTile _buildTile(MediaModel media) {
    return GridTile(
      footer: _buildTileFooter(media),
      child: Hero(
        tag: media.mediaUri,
        child: Image.network(MediaQueryProvider.toThumbnailUrl(media.mediaUri),
            fit: BoxFit.cover,
            cacheHeight: ThumbnailDimension.height,
            cacheWidth: ThumbnailDimension.width),
      ),
    );
  }

  GridTileBar _buildTileFooter(MediaModel media) {
    return GridTileBar(
        backgroundColor: backgroundColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            verticalSpace,
            Text(media.title,
                overflow: TextOverflow.ellipsis, style: titleFont),
            verticalSpace,
            Row(
              children: <Widget>[
                hitIcon,
                verticalSpace,
                Text(media.hitCount.toString(), style: normalFont),
                const Spacer(),
                likeIcon,
                verticalSpace,
                Text(media.likeCount.toString(), style: normalFont),
                const Spacer(),
                commentIcon,
                verticalSpace,
                Text(media.commentCount.toString(), style: normalFont),
              ],
            )
          ],
        ));
  }
}
