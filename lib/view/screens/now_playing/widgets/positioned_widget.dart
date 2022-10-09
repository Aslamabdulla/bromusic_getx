import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/view/screens/now_playing/widgets/animated_widget.dart';
import 'package:flutter/material.dart';

class PosionedWidgetImage extends StatelessWidget {
  const PosionedWidgetImage({
    Key? key,
    required this.height,
    required this.player,
    required this.width,
  }) : super(key: key);

  final double height;
  final AssetsAudioPlayer player;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: height - height,
      top: height * .05,
      child: Center(
          child: PlayerBuilder.isPlaying(
        player: player,
        builder: (context, glowAnimate) {
          return AnimatedContainerWidget(
              width: width, height: height, glowAnimate: glowAnimate);
        },
      )),
    );
  }
}
