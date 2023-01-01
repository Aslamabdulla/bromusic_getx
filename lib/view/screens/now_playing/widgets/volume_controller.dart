import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/dependencies/dependencies.dart';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class VolumeControllerWidget extends StatelessWidget {
  VolumeControllerWidget({
    Key? key,
    required this.player,
    required this.width,
  }) : super(key: key);
  AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  final double width;

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      onChange: ((value) {
        musicController.volume = value;
        player.setVolume(musicController.volume);
      }),
      min: 0,
      max: 1,
      initialValue: musicController.volume,
      appearance: CircularSliderAppearance(
          animationEnabled: false,
          size: width / 1.5,
          counterClockwise: true,
          startAngle: 180,
          angleRange: 180,
          customWidths: CustomSliderWidths(
              trackWidth: 10, progressBarWidth: 20, shadowWidth: 0),
          customColors: CustomSliderColors(
              trackColor: Colors.white,
              progressBarColor: const Color.fromRGBO(88, 66, 50, 1)),
          infoProperties: InfoProperties(
              mainLabelStyle: const TextStyle(color: Colors.transparent))),
    );
  }
}
