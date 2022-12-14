// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:bromusic/controller/controller.dart';
import 'package:bromusic/dependencies/dependencies.dart';

import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/settings.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';

import 'package:bromusic/view/screens/now_playing/widgets/decor_widget.dart';
import 'package:bromusic/view/screens/now_playing/widgets/fav_button.dart';

import 'package:bromusic/view/screens/now_playing/widgets/icon_widget.dart';
import 'package:bromusic/view/screens/now_playing/widgets/loop_button.dart';
import 'package:bromusic/view/screens/now_playing/widgets/play_pause_widget.dart';
import 'package:bromusic/view/screens/now_playing/widgets/positioned_widget.dart';
import 'package:bromusic/view/screens/now_playing/widgets/progress_bar_widget.dart';
import 'package:bromusic/view/screens/now_playing/widgets/shuffle_button.dart';

import 'package:bromusic/view/screens/now_playing/widgets/volume_widget.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class NowPlayingScreen extends StatelessWidget {
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
  bool isPlaySong = true;
  NowPlayingScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dataBaseSongs = box.get("music") as List<AllAudios>;
    });
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          actions: [
            IconAppBar(
                fnctn: () => Get.to(() => const SettingsScreen(),
                    transition: Transition.leftToRightWithFade,
                    duration: const Duration(milliseconds: 300)),
                icon: Icons.settings),
          ],
          leading: IconAppBar(
            fnctn: () => Get.back(),
            icon: Icons.chevron_left,
          ),
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
            final mySongs = musicController.find(musicController.fullSongs,
                currentPlaying!.audio.assetAudioPath);

            favSongs = box.get("favourites");
            return ListView(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                Stack(
                  children: [
                    DecorWidget(height: height, width: width, mySongs: mySongs),
                    PosionedWidgetImage(
                        height: height, player: player, width: width),
                    PositionedVolumeWidget(
                        width: width, height: height, player: player)
                  ],
                ),
                player.builderRealtimePlayingInfos(
                  builder: ((context, infos) {
                    return Container(
                      height: height / 2.5,
                      padding: const EdgeInsets.only(top: 0),
                      child: SizedBox(
                        width: 150,
                        child: GetBuilder<MusicController>(
                            init: MusicController(),
                            builder: (MusicController controller) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 300,
                                      child: ProgressBarWidget(
                                          infos: infos, player: player)),
                                  SizedBox(
                                    height: height * .01,
                                    width: width,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        iconSize: 100,
                                        onPressed: () {
                                          prev();
                                        },
                                        icon: const FaIcon(
                                          FontAwesomeIcons.backwardStep,
                                          size: 40,
                                        ),
                                      ),

                                      PlayerBuilder.isPlaying(
                                          player: player,
                                          builder: (context, nowplaying) {
                                            isPlaySong = nowplaying;
                                            return PlayPauseWidget(
                                                nowplaying: nowplaying,
                                                player: player);
                                          }),

                                      ////////////

                                      IconButton(
                                        iconSize: 100,
                                        onPressed: () {
                                          next();
                                        },
                                        icon: const FaIcon(
                                          FontAwesomeIcons.forwardStep,
                                          size: 40,
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const ShuffleButtonwidget(),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      const LoopButttonWidget(),
                                      const SizedBox(
                                        width: 50,
                                      ),
                                      FavRoundButton(
                                          songId: mySongs.metas.id.toString())
                                    ],
                                  )
                                ],
                              );
                            }),
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
