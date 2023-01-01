import 'package:bromusic/dependencies/dependencies.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ImageWidget extends StatelessWidget {
  final int index;
  ImageWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: boxDecorSongsTitle(),
        width: 80,
        height: 70,
        child: QueryArtworkWidget(
            artworkClipBehavior: Clip.none,
            artworkFit: BoxFit.cover,
            nullArtworkWidget: Container(
              child: Image.asset(
                "assets/images/tapeedit.png",
                fit: BoxFit.cover,
              ),
            ),
            id: int.parse(musicController.fullSongs[index].metas.id.toString()),
            type: ArtworkType.AUDIO));
  }
}
