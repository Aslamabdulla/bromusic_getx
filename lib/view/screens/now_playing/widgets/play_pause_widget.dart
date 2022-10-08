import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/main.dart';
import 'package:flutter/material.dart';

class PlayPauseWidget extends StatelessWidget {
  final bool nowplaying;
  const PlayPauseWidget({
    Key? key,
    required this.nowplaying,
    required this.player,
  }) : super(key: key);

  final AssetsAudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 100,
        onPressed: () async {
          await player.playOrPause();
          if (nowplaying) {
            musicController.animationController.stop();
          } else {
            musicController.animationController.repeat();
          }
        },
        icon: Icon(
          nowplaying
              ? Icons.pause_circle_filled_rounded
              : Icons.play_circle_rounded,
        ));
  }
}
