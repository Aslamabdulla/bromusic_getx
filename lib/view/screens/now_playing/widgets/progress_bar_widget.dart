import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

class ProgressBarWidget extends StatelessWidget {
  final RealtimePlayingInfos infos;
  const ProgressBarWidget({
    Key? key,
    required this.infos,
    required this.player,
  }) : super(key: key);

  final AssetsAudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      progressBarColor: Colors.amber,
      thumbColor: Colors.black,
      progress: infos.currentPosition,
      buffered: const Duration(),
      total: infos.duration,
      onSeek: (to) {
        player.seek(to);
        // print('User selected a new time: $duration');
      },
    );
  }
}
