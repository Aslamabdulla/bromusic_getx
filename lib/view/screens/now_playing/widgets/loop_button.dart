import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/controller/now_playing_controller.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class LoopButttonWidget extends StatelessWidget {
  const LoopButttonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NowPlayingController>(
        init: NowPlayingController(),
        builder: (NowPlayingController nowPlayingController) {
          return nowPlayingController.isLoopMode == false
              ? Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(10, 4, 3, 1),
                  ),
                  child: IconButton(
                      onPressed: () async {
                        nowPlayingController.isLoopMode = true;
                        nowPlayingController.loopMode(LoopMode.playlist);
                      },
                      icon: const Icon(
                        Icons.repeat,
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
                        nowPlayingController.isLoopMode = false;
                        nowPlayingController.loopMode(LoopMode.single);
                      },
                      icon: Icon(
                        Icons.repeat_one_rounded,
                        color: commonYellow(),
                      )),
                );
        });
  }
}
