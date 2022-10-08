import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/controller/now_playing_controller.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShuffleButtonwidget extends StatelessWidget {
  const ShuffleButtonwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NowPlayingController>(
        init: NowPlayingController(),
        builder: (NowPlayingController nowPlayingController) {
          return !nowPlayingController.shuffleSong
              ? Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(10, 4, 3, 1),
                  ),
                  child: IconButton(
                      onPressed: () async {
                        nowPlayingController.shuffleSong = true;
                        nowPlayingController.loopMode(LoopMode.none);
                      },
                      icon: const Icon(
                        Icons.shuffle_rounded,
                        color: Colors.white,
                      )),
                )
              : Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(10, 4, 3, 1),
                  ),
                  child: IconButton(
                      onPressed: () async {
                        nowPlayingController.shuffleSong = false;
                        nowPlayingController.loopMode(LoopMode.playlist);
                      },
                      icon: Icon(
                        Icons.shuffle_on_rounded,
                        color: commonYellow(),
                      )),
                );
        });
  }
}
