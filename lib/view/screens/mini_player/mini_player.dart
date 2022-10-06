// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:bromusic/controller/controller.dart';
import 'package:bromusic/main.dart';
import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/common.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/screens/mini_player/widgets/mini_image.dart';
import 'package:bromusic/view/screens/now_playing.dart';

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

  bool nextDone = true;
  bool prevDone = true;
  final box = SongBox.getInstance();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return GetBuilder<MusicController>(
        init: MusicController(),
        builder: (MusicController musicController) {
          return player.builderCurrent(builder: (context, playing) {
            musicController.favSongs = box.get("favourites");
            var audioFile =
                find(musicController.fullSongs, playing.audio.assetAudioPath);
            var currentAudio = musicController.dataBaseSongs.firstWhere(
                (element) =>
                    element.id.toString() == audioFile.metas.id.toString());
            return GestureDetector(
              onTap: () async {
                await Navigator.of(context)
                    .push(CupertinoPageRoute(builder: ((context) {
                  return NowPlayingScreen(
                      fullSongs: musicController.fullSongs, index: index);
                })));
              },
              child: ValueListenableBuilder(
                valueListenable: switched,
                builder: (context, value, _) {
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: miniPlayerBoxDecoration(),
                    margin:
                        const EdgeInsets.only(bottom: 0, left: 10, right: 10),
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
                              width: width,
                              height: height,
                              audioFile: audioFile),
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
                                Container(
                                  width: width * .59,
                                  child: textHomeFunction(
                                      audioFile.metas.title!, 12),
                                ),
                              ],
                            ),
                            Container(
                              width: width * .55,
                              child:
                                  textHomeFunction(audioFile.metas.artist!, 11),
                            ),
                            Container(
                              width: width / 1.55,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      prev();
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.backwardStep,
                                      size: width * .050,
                                    ),
                                  ),
                                  PlayerBuilder.isPlaying(
                                      player: player,
                                      builder: (context, nowplaying) {
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
                                  StatefulBuilder(
                                    builder: (BuildContext context,
                                        void Function(void Function())
                                            setState) {
                                      return musicController.favSongs!
                                              .where((element) =>
                                                  element.id.toString() ==
                                                  currentAudio.id.toString())
                                              .isEmpty
                                          ? Container(
                                              height: height * .05,
                                              width: width * .090,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    Color.fromRGBO(10, 4, 3, 1),
                                              ),
                                              //////////Want to avoid set
                                              child: Center(
                                                child: IconButton(
                                                    onPressed: () async {
                                                      setState(() {
                                                        musicController.favSongs
                                                            ?.add(currentAudio);
                                                        box.put(
                                                            "favourites",
                                                            musicController
                                                                .favSongs!);
                                                        musicController
                                                                .favSongs =
                                                            box.get(
                                                                "favourites");
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.favorite_outline,
                                                      color: Colors.white,
                                                      size: width * .04,
                                                    )),
                                              ),
                                            )
                                          : Container(
                                              height: height * .05,
                                              width: width * .1,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    Color.fromRGBO(10, 4, 3, 1),
                                              ),
                                              child: Center(
                                                child: IconButton(
                                                    onPressed: () async {
                                                      setState(
                                                        () {
                                                          musicController.favSongs!
                                                              .removeWhere((element) =>
                                                                  element.id
                                                                      .toString() ==
                                                                  currentAudio
                                                                      .id
                                                                      .toString());

                                                          box.put(
                                                              "favourites",
                                                              musicController
                                                                  .favSongs!);
                                                        },
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.favorite,
                                                      color: commonRed(),
                                                      size: width * .04,
                                                    )),
                                              ),
                                            );
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  )
                                ],
                              ),
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
        });
  }

  void next() async {
    if (nextDone) {
      nextDone = false;
      await player.next();
      nextDone = true;
    }
  }

  void prev() async {
    if (prevDone) {
      prevDone = false;
      await player.previous();
      prevDone = true;
    }
  }
}
