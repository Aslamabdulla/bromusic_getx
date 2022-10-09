import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/view/screens/now_playing/widgets/volume_controller.dart';
import 'package:flutter/material.dart';

class PositionedVolumeWidget extends StatelessWidget {
  const PositionedVolumeWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.player,
  }) : super(key: key);

  final double width;
  final double height;
  final AssetsAudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: width * .165,
      bottom: height * .01,
      child:
          Center(child: VolumeControllerWidget(player: player, width: width)),
    );
  }
}
