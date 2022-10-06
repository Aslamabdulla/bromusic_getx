import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ImageWidgetFavourites extends StatelessWidget {
  int index;
  ImageWidgetFavourites({
    Key? key,
    required this.index,
    required this.favSongs,
  }) : super(key: key);

  final List favSongs;

  @override
  Widget build(BuildContext context) {
    return QueryArtworkWidget(
        artworkClipBehavior: Clip.none,
        artworkFit: BoxFit.cover,
        nullArtworkWidget: Container(
          child: Image.asset(
            "assets/images/tapeedit.png",
            fit: BoxFit.cover,
          ),
        ),
        id: favSongs[index].id,
        type: ArtworkType.AUDIO);
  }
}
