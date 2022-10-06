// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/view/screens/all_songs/widgets/list_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:bromusic/controller/controller.dart';
import 'package:bromusic/main.dart';
import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';

import 'package:bromusic/view/decoration/box_decoration.dart';

import 'package:bromusic/view/screens/mini_player/mini_player.dart';
import 'package:bromusic/view/screens/now_playing/now_playing.dart';
import 'package:bromusic/view/screens/player/player.dart';

class AllSongs extends StatelessWidget {
  AllSongs({super.key});

  final userTemp = preference.getString("user");
  dynamic miniPlayer;

  String currentSongTitle = '';
  int currentIndex = 1;
  bool isPlayerViewVisible = true;
  bool isTapped = false;
  final _audioQuery = OnAudioQuery();

  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        musicController.dataBaseSongs =
            musicController.box.get("music") as List<AllAudios>;
        musicController.favouriteSongs = musicController.box.get("favourites");
      },
    );
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return SafeArea(
        child: GetBuilder<MusicController>(
            init: MusicController(),
            builder: (MusicController musicController) {
              return ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    height: isTapped
                        ? height
                        : height, ///// want to change the container size
                    width: width,
                    padding: EdgeInsets.only(bottom: height / 5.76),

                    child: FutureBuilder<List<SongModel>>(
                      future: _audioQuery.querySongs(
                          sortType: SongSortType.DISPLAY_NAME,
                          orderType: OrderType.ASC_OR_SMALLER,
                          uriType: UriType.EXTERNAL,
                          ignoreCase: true),
                      builder: (context, item) {
                        if (item.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (item.data!.isEmpty) {
                          return const Center(child: Text("Empty Songs"));
                        }

                        return ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),

                          itemBuilder: (context, index) {
                            List? recentlyPlay =
                                musicController.box.get("recent");

                            final cache = savedSongs(
                                musicController.dataBaseSongs,
                                musicController.fullSongs[index].metas.id
                                    .toString());

                            return Container(
                              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: SlideInRight(
                                key: const Key("30"),
                                child: GestureDetector(
                                  onTap: () async {
                                    CurrentlyPlaying(
                                            fullSongs: [], index: index)
                                        .openAudioPlayer(
                                            index: index,
                                            audios: musicController.fullSongs);
                                    currentIndex = index;
                                    isTapped = true;
                                    List existingSong = [];
                                    existingSong = recentlyPlay!
                                        .where((element) =>
                                            element.id.toString() ==
                                            cache.id.toString())
                                        .toList();
                                    if (existingSong.isEmpty) {
                                      recentlyPlay.add(cache);
                                      var temp = recentlyPlay.toSet().toList();
                                      if (temp.length > 15) {
                                        temp.removeAt(0);
                                      }

                                      await musicController.box
                                          .put("recent", temp);
                                    }

                                    musicController.dataBaseSongs[index].count =
                                        musicController
                                                .dataBaseSongs[index].count! +
                                            1;

                                    showBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        clipBehavior: Clip.hardEdge,
                                        context: context,
                                        builder: (context) =>
                                            MiniPlayer(index: index));
                                  },
                                  onDoubleTap: () async {
                                    await Get.to(() => NowPlayingScreen());
                                  },
                                  child: ValueListenableBuilder(
                                    valueListenable: switched,
                                    builder: (context, value, _) {
                                      return ListTileWidget(
                                          index: index,
                                          width: width,
                                          cache: cache);
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: musicController.fullSongs.length,
                          // item.data!.length,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //
                ],
              );
            }));
  }

  void playSong() {
    {
      if (isTapped) {
        player.play();
      } else {
        player.pause();
      }
    }
  }

  AllAudios savedSongs(List<AllAudios> audios, String id) {
    /////Funct ion
    return audios.firstWhere((element) => element.id.toString().contains(id));
  }
}
