import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayerImageWidget extends StatelessWidget {
  const MiniPlayerImageWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.audioFile,
  }) : super(key: key);

  final double width;
  final double height;
  final Audio audioFile;

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: boxDecorMiniTitle(),
        width: width * .17,
        height: height * .08,
        child: QueryArtworkWidget(
            artworkBlendMode: BlendMode.luminosity,
            keepOldArtwork: true,
            artworkClipBehavior: Clip.none,
            artworkFit: BoxFit.cover,
            nullArtworkWidget: Container(
              child: Image.asset(
                "assets/images/tapeedit.png",
                fit: BoxFit.cover,
              ),
            ),
            id: int.parse(audioFile.metas.id!),
            type: ArtworkType.AUDIO));
  }
}
