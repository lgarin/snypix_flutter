import 'package:flutter/material.dart';
import 'package:snypix_flutter/app/data/models/media_model.dart';
import 'package:snypix_flutter/app/modules/home/gallery_controller.dart';
import 'package:snypix_flutter/app/modules/home/widgets/thumbnail_widget.dart';
import 'package:snypix_flutter/app/modules/content/paged_view.dart';
import 'package:snypix_flutter/core/values/consts.dart';

class GalleryView extends PagedView<MediaModel, GalleryController> {
  static const backgroundIcon =
      Icon(Icons.panorama, size: 100, color: Colors.grey);
  static const noContentText = 'No content yet';
  static const noContentSubText = 'Be the first to post some media here.';

  GalleryView(String? categoryToken)
      : super(tag: categoryToken, key: ValueKey(categoryToken));

  @override
  Widget buildContent(BuildContext context, List<MediaModel> data) {
    if (data.isEmpty) {
      return Center(child: _buildNoContent(context));
    }

// TODO use GetResponsiveWidget
    final portrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return GridView.count(
        crossAxisCount: portrait ? 2 : 3,
        childAspectRatio: 16.0 / 9.0,
        mainAxisSpacing: FixedSpace.spacing,
        crossAxisSpacing: FixedSpace.spacing,
        padding: FixedSpace.padding,
        children: data.map(_buildGridTile).toList());
  }

  Widget _buildGridTile(MediaModel media) {
    return ThumbnailWidget(
        media: media, onTapCallback: controller.onGridTileSelection);
  }

  Column _buildNoContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        backgroundIcon,
        Text(noContentText, style: Theme.of(context).textTheme.titleLarge),
        const Text(noContentSubText)
      ],
    );
  }
}
