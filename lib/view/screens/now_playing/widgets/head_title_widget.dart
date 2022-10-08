import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:flutter/material.dart';

class HeadTitleWidget extends StatelessWidget {
  const HeadTitleWidget({
    Key? key,
    required this.width,
    required this.mySongs,
    required this.height,
  }) : super(key: key);

  final double width;
  final Audio mySongs;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width - 20,
          child: textNowPlayingFunction(mySongs.metas.title!, height * .03),
        ),
        textNowPlayingSubFunction(
            mySongs.metas.artist == "<unknown>"
                ? "Unknown Artist"
                : mySongs.metas.artist!,
            18)
      ],
    );
  }
}
