// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:avatar_glow/avatar_glow.dart';

import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/settings.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class NowPlayingScreen extends StatefulWidget {
  final List<Audio> fullSongs;
  final int index;
  const NowPlayingScreen(
      {Key? key, required this.fullSongs, required this.index})
      : super(key: key);

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  ///commented
  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen>
    with TickerProviderStateMixin {
  bool nextDone = true;

  bool prevDone = true;

  bool hideButton = true;
  String songTitle = "";
  AllAudios? music;
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");

  final box = SongBox.getInstance();
  List<AllAudios> dataBaseSongs = [];
  List<dynamic>? favSongs = [];

  bool isPlaying = true;
  bool shuffleSong = false;
  bool loopSong = false;

  @override
  void initState() {
    super.initState();

    dataBaseSongs = box.get("music") as List<AllAudios>;
  }

  final slider = SleekCircularSlider(
    appearance: CircularSliderAppearance(
      counterClockwise: true,
      size: .5,
      customWidths: CustomSliderWidths(progressBarWidth: 10),
    ),
    min: 0,
    max: 28,
    initialValue: 14,
  );
  void confirmed() {}
  double transalateX = 0.0;
  double translateY = 0.0;
  double myWidth = 0;
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) {
                    return const SettingsScreen();
                  },
                ));
              },
              icon: const Icon(
                Icons.settings,
                size: 30,
              ),
              color: Colors.black,
            ),
          ],
          leading: IconButton(
              onPressed: (() {
                Navigator.of(context).pop();
              }),
              icon: const Icon(
                Icons.chevron_left,
                size: 40,
                color: Colors.black,
              )),
          backgroundColor: switched.value
              ? const Color.fromRGBO(255, 110, 6, .9)
              : const Color.fromRGBO(255, 201, 0, .9),
          elevation: 0,
          title: Text("NOW PLAYING", style: textHead()),
          centerTitle: true,
        ),
        body: Container(
          height: height,
          width: width,
          child: player.builderCurrent(
              builder: (context, Playing? currentPlaying) {
            final mySongs = widget.find(
                widget.fullSongs, currentPlaying!.audio.assetAudioPath);
            final currentAudio = dataBaseSongs.firstWhere((element) =>
                element.id.toString() == mySongs.metas.id.toString());
            favSongs = box.get("favourites");
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                Stack(
                  children: [
                    Container(
                      height: .38 * height,
                      width: width,
                      decoration: boxDecorTwoEdge(),
                      child: Column(
                        children: [
                          Container(
                            width: width - 20,
                            child: textNowPlayingFunction(
                                mySongs.metas.title!, height * .03),
                          ),
                          textNowPlayingSubFunction(
                              mySongs.metas.artist == "<unknown>"
                                  ? "Unknown Artist"
                                  : mySongs.metas.artist!,
                              18)
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: height - height,
                      top: height * .05,
                      child: Center(
                          child: PlayerBuilder.isPlaying(
                        player: player,
                        builder: (context, glowAnimate) {
                          return AvatarGlow(
                            glowColor: Colors.grey.shade600,
                            animate: glowAnimate,
                            endRadius: width / 2,
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              child: QueryArtworkWidget(
                                nullArtworkWidget: Image.asset(
                                  "assets/images/4.png",
                                  fit: BoxFit.cover,
                                ),
                                type: ArtworkType.AUDIO,
                                id: int.parse(mySongs.metas.id!),
                                artworkFit: BoxFit.cover,
                              ),
                              height: height * .24,
                              width: width / 2,
                              // margin: EdgeInsets.all(80),
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, .4),
                                    blurRadius: 14,
                                    spreadRadius: 3,
                                    offset: Offset(0, 0.0),
                                  ),
                                ],
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        },
                      )),
                    ),
                    Positioned(
                      left: width * .165,
                      bottom: height * .01,
                      child: Center(
                        child: SleekCircularSlider(
                          onChange: ((value) {
                            player.setVolume(value);
                          }),
                          min: 0,
                          max: 1,
                          initialValue: 1,
                          appearance: CircularSliderAppearance(
                              size: width / 1.5,
                              counterClockwise: true,
                              startAngle: 180,
                              angleRange: 180,
                              customWidths: CustomSliderWidths(
                                  trackWidth: 10,
                                  progressBarWidth: 20,
                                  shadowWidth: 0),
                              customColors: CustomSliderColors(
                                  trackColor: Colors.white,
                                  progressBarColor:
                                      const Color.fromRGBO(88, 66, 50, 1)),
                              infoProperties: InfoProperties(
                                  mainLabelStyle: const TextStyle(
                                      color: Colors.transparent))),
                        ),
                      ),
                    )
                  ],
                ),
                player.builderRealtimePlayingInfos(
                  builder: ((context, infos) {
                    return Container(
                      height: height / 2.5,
                      padding: const EdgeInsets.only(top: 0),
                      child: SizedBox(
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300,
                              child: ProgressBar(
                                progressBarColor: Colors.amber,
                                thumbColor: Colors.black,
                                progress: infos.currentPosition,
                                buffered: const Duration(),
                                total: infos.duration,
                                onSeek: (to) {
                                  player.seek(to);
                                  // print('User selected a new time: $duration');
                                },
                              ),
                            ),
                            SizedBox(
                              height: height * .01,
                              width: width,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                PlayerBuilder.isPlaying(
                                    player: player,
                                    builder: (context, nowplaying) {
                                      return IconButton(
                                        iconSize: 100,
                                        onPressed: () {
                                          prev();
                                        },
                                        icon: const FaIcon(
                                          FontAwesomeIcons.backwardStep,
                                          size: 40,
                                        ),
                                      );
                                    }),

                                PlayerBuilder.isPlaying(
                                    player: player,
                                    builder: (context, nowplaying) {
                                      return IconButton(
                                          iconSize: 100,
                                          onPressed: () async {
                                            await player.playOrPause();
                                          },
                                          icon: Icon(
                                            nowplaying
                                                ? Icons
                                                    .pause_circle_filled_rounded
                                                : Icons.play_circle_rounded,
                                          ));
                                    }),

                                ////////////
                                PlayerBuilder.isPlaying(
                                    player: player,
                                    builder: (context, nowplaying) {
                                      return IconButton(
                                        iconSize: 100,
                                        onPressed: () {
                                          next();
                                        },
                                        icon: const FaIcon(
                                          FontAwesomeIcons.forwardStep,
                                          size: 40,
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) setState) {
                                    return !shuffleSong
                                        ? Container(
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Color.fromRGBO(10, 4, 3, 1),
                                            ),
                                            child: IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    shuffleSong = true;
                                                  });
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
                                              color:
                                                  Color.fromRGBO(10, 4, 3, 1),
                                            ),
                                            child: IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    shuffleSong = false;
                                                    player.setLoopMode(
                                                        LoopMode.playlist);
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.shuffle_on_rounded,
                                                  color: commonYellow(),
                                                )),
                                          );
                                  },
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) setState) {
                                    return !loopSong
                                        ? Container(
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Color.fromRGBO(10, 4, 3, 1),
                                            ),
                                            child: IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    loopSong = true;
                                                    player.setLoopMode(
                                                        LoopMode.single);
                                                  });
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
                                              color:
                                                  Color.fromRGBO(10, 4, 3, 1),
                                            ),
                                            child: IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    loopSong = false;
                                                    player.setLoopMode(
                                                        LoopMode.playlist);
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.repeat_one_rounded,
                                                  color: commonYellow(),
                                                )),
                                          );
                                  },
                                ),
                                const SizedBox(
                                  width: 50,
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
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Color.fromRGBO(10, 4, 3, 1),
                                            ),
                                            child: IconButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    favSongs?.add(currentAudio);
                                                    box.put("favourites",
                                                        favSongs!);
                                                    favSongs =
                                                        box.get("favourites");
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.favorite_outline,
                                                  color: Colors.white,
                                                )),
                                          )
                                        : Container(
                                            height: 50,
                                            width: 50,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Color.fromRGBO(10, 4, 3, 1),
                                            ),
                                            child: IconButton(
                                                onPressed: () async {
                                                  setState(
                                                    () {
                                                      favSongs!.removeWhere(
                                                          (element) =>
                                                              element.id
                                                                  .toString() ==
                                                              currentAudio.id
                                                                  .toString());

                                                      box.put("favourites",
                                                          favSongs!);
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.favorite,
                                                  color: Colors.amberAccent,
                                                )),
                                          );
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                )
              ],
            );
          }),
        ),
      ),
    );
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
