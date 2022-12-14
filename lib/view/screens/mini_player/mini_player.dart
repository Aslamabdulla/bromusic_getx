// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/dependencies/dependencies.dart';
import 'package:bromusic/view/common_widgets/favorite_button.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:bromusic/controller/controller.dart';

import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/common.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/screens/mini_player/widgets/mini_image.dart';
import 'package:bromusic/view/screens/now_playing/now_playing.dart';

bool isPlayMode = false;

class MiniPlayer extends StatelessWidget {
  int index;
  MiniPlayer({
    Key? key,
    required this.index,
  }) : super(key: key);
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  final box = SongBox.getInstance();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return player.builderCurrent(builder: (context, playing) {
      musicController.favSongs = box.get("favourites");
      var audioFile =
          find(musicController.fullSongs, playing.audio.assetAudioPath);

      return GestureDetector(
        onTap: () async {
          await Get.to(() => NowPlayingScreen(),
              transition: Transition.leftToRightWithFade,
              duration: const Duration(milliseconds: 300));
        },
        child: ValueListenableBuilder(
          valueListenable: switched,
          builder: (context, value, _) {
            return Container(
              clipBehavior: Clip.hardEdge,
              decoration: miniPlayerBoxDecoration(),
              margin: const EdgeInsets.only(bottom: 0, left: 10, right: 10),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              height: height * .16,
              width: width - 10,
              // color: Color.fromARGB(255, 232, 9, 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: MiniPlayerImageWidget(
                        width: width, height: height, audioFile: audioFile),
                  ),
                  SizedBox(
                    width: width * .02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: width * .59,
                            child: textHomeFunction(audioFile.metas.title!, 12),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: width * .55,
                        child: textHomeFunction(audioFile.metas.artist!, 11),
                      ),
                      SizedBox(
                        width: width / 1.55,
                        child: GetBuilder<MusicController>(
                            init: MusicController(),
                            builder: (MusicController musicController) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  iconSongController(width),
                                  PlayerBuilder.isPlaying(
                                      player: player,
                                      builder: (context, nowplaying) {
                                        isPlayMode = nowplaying;
                                        return IconButton(
                                            iconSize: height * .050,
                                            onPressed: () async {
                                              await player.playOrPause();
                                            },
                                            icon: Icon(nowplaying
                                                ? Icons
                                                    .pause_circle_filled_rounded
                                                : Icons.play_circle_rounded));
                                      }),
                                  IconButton(
                                    onPressed: () {
                                      next();
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.forwardStep,
                                      size: width * .050,
                                    ),
                                  ),
                                  FavIconWidget(
                                      key: const Key("favBtn"),
                                      controller: musicController,
                                      songId: audioFile.metas.id.toString()),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              );
                            }),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      );
    });
  }

  IconButton iconSongController(
    double width,
  ) {
    return IconButton(
      onPressed: () {
        prev();
      },
      icon: FaIcon(
        FontAwesomeIcons.backwardStep,
        size: width * .050,
      ),
    );
  }

  void next() async {
    if (musicController.nextDone) {
      musicController.nextDone = false;
      await player.next();
      musicController.nextDone = true;
    }
  }

  void prev() async {
    if (musicController.prevDone) {
      musicController.prevDone = false;
      await player.previous();
      musicController.prevDone = true;
    }
  }
}
