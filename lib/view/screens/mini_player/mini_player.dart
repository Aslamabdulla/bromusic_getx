// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/main.dart';
import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/common.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/screens/now_playing.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  MiniPlayer({Key? key, required this.allSongs, required this.index})
      : super(key: key);
  // SongModel? songModel;
  final List<Audio> allSongs;
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  final index;
  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}

class _MiniPlayerState extends State<MiniPlayer> {
  bool nextDone = true;
  bool prevDone = true;
  final box = SongBox.getInstance();
  List<dynamic>? favSongs = [];
  bool isPlaying = true;
  @override
  void initState() {
    super.initState();
    isPlaying = true;
    favSongs = box.get("favourites"); // playsong();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return widget.player.builderCurrent(builder: (context, playing) {
      favSongs = box.get("favourites");
      final audioFile = find(fullSongs, playing.audio.assetAudioPath);
      final currentAudio = dataBaseSongs.firstWhere(
          (element) => element.id.toString() == audioFile.metas.id.toString());
      return GestureDetector(
        onTap: () async {
          await Navigator.of(context)
              .push(CupertinoPageRoute(builder: ((context) {
            return NowPlayingScreen(fullSongs: fullSongs, index: widget.index);
          })));
        },
        child: ValueListenableBuilder(
          valueListenable: switched,
          builder: (context, value, _) {
            return Container(
              clipBehavior: Clip.hardEdge,
              decoration: miniPlayerBoxDecoration(),
              margin: const EdgeInsets.only(bottom: 0, left: 10, right: 10),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              height: height * .20,
              width: width - 10,
              // color: Color.fromARGB(255, 232, 9, 9),
              child: Row(
                children: [
                  Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: boxDecorSongsTitle(),
                      width: width * .180,
                      height: height * .12,
                      child: QueryArtworkWidget(
                          artworkClipBehavior: Clip.none,
                          artworkFit: BoxFit.cover,
                          nullArtworkWidget: Container(
                            child: Image.asset(
                              "assets/images/tapeedit.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          id: int.parse(audioFile.metas.id!),
                          type: ArtworkType.AUDIO)),
                  SizedBox(
                    width: width * .02,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: width * .59,
                            child: textHomeFunction(audioFile.metas.title!, 12),
                          ),
                          const SizedBox(),
                        ],
                      ),
                      Container(
                        width: width * .55,
                        child: textHomeFunction(audioFile.metas.artist!, 11),
                      ),
                      Container(
                        width: width / 1.55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                player: widget.player,
                                builder: (context, nowplaying) {
                                  return IconButton(
                                      iconSize: height * .070,
                                      onPressed: () async {
                                        await widget.player.playOrPause();
                                      },
                                      icon: Icon(nowplaying
                                          ? Icons.pause_circle_filled_rounded
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
                                  void Function(void Function()) setState) {
                                return favSongs!
                                        .where((element) =>
                                            element.id.toString() ==
                                            currentAudio.id.toString())
                                        .isEmpty
                                    ? Container(
                                        height: height * .1,
                                        width: width * .090,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(10, 4, 3, 1),
                                        ),
                                        child: IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                favSongs?.add(currentAudio);
                                                box.put(
                                                    "favourites", favSongs!);
                                                favSongs =
                                                    box.get("favourites");
                                              });
                                            },
                                            icon: Icon(
                                              Icons.favorite_outline,
                                              color: Colors.white,
                                              size: width * .045,
                                            )),
                                      )
                                    : Container(
                                        height: height * .10,
                                        width: width * .090,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromRGBO(10, 4, 3, 1),
                                        ),
                                        child: IconButton(
                                            onPressed: () async {
                                              setState(
                                                () {
                                                  favSongs!.removeWhere(
                                                      (element) =>
                                                          element
                                                              .id
                                                              .toString() ==
                                                          currentAudio.id
                                                              .toString());

                                                  box.put(
                                                      "favourites", favSongs!);
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              Icons.favorite,
                                              color: commonRed(),
                                              size: width * .045,
                                            )),
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
  }

  void next() async {
    if (nextDone) {
      nextDone = false;
      await widget.player.next();
      nextDone = true;
    }
  }

  void prev() async {
    if (prevDone) {
      prevDone = false;
      await widget.player.previous();
      prevDone = true;
    }
  }
}
