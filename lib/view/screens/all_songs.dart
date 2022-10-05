import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:bromusic/main.dart';

import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/common.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/menu_item/pop_up.dart';
import 'package:bromusic/view/screens/mini_player/mini_player.dart';
import 'package:bromusic/view/screens/now_playing.dart';
import 'package:bromusic/view/screens/player/player.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';

class AllSongs extends StatefulWidget {
  const AllSongs({
    Key? key,
  }) : super(key: key);

  @override
  State<AllSongs> createState() => _AllSongsState();
}

final userTemp = preference.getString("user");
dynamic miniPlayer;

class _AllSongsState extends State<AllSongs> {
  List<AllAudios> dataBaseSongs = [];
  List<AllAudios>? dbSongs = [];
  List<dynamic> favourites = [];
  List<dynamic> favSongs = [];
  List? favouriteSongs = [];

  final box = SongBox.getInstance();

  final _audioQuery = OnAudioQuery();

  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  List<SongModel> songs = [];
  String currentSongTitle = '';
  int currentIndex = 1;
  bool isPlayerViewVisible = true;
  bool isTapped = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataBaseSongs = box.get("music") as List<AllAudios>;
    favouriteSongs = box.get("favourites");
  }

  var iconsize = 30;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return SafeArea(
        child: ListView(
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
                  List? recentlyPlay = box.get("recent");

                  final cache = savedSongs(
                      dataBaseSongs, fullSongs[index].metas.id.toString());

                  return Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: SlideInRight(
                      key: const Key("30"),
                      child: GestureDetector(
                        onTap: () async {
                          CurrentlyPlaying(fullSongs: [], index: index)
                              .openAudioPlayer(index: index, audios: fullSongs);
                          currentIndex = index;
                          isTapped = true;
                          List existingSong = [];
                          existingSong = recentlyPlay!
                              .where((element) =>
                                  element.id.toString() == cache.id.toString())
                              .toList();
                          if (existingSong.isEmpty) {
                            recentlyPlay.add(cache);
                            var temp = recentlyPlay.toSet().toList();
                            if (temp.length > 15) {
                              temp.removeAt(0);
                            }

                            await box.put("recent", temp);
                          }

                          showBottomSheet(
                              backgroundColor: Colors.transparent,
                              clipBehavior: Clip.hardEdge,
                              context: context,
                              builder: (context) => MiniPlayer(
                                  allSongs: fullSongs, index: index));
                        },
                        onDoubleTap: () async {
                          await Navigator.of(context)
                              .push(CupertinoPageRoute(builder: ((context) {
                            return NowPlayingScreen(
                                fullSongs: fullSongs, index: currentIndex);
                          })));
                        },
                        child: ValueListenableBuilder(
                          valueListenable: switched,
                          builder: (context, value, _) {
                            return Container(
                              decoration: playlistBoxDecoration(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              height: 90,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                              clipBehavior: Clip.hardEdge,
                                              decoration: boxDecorSongsTitle(),
                                              width: 80,
                                              height: 70,
                                              child: QueryArtworkWidget(
                                                  artworkClipBehavior:
                                                      Clip.none,
                                                  artworkFit: BoxFit.cover,
                                                  nullArtworkWidget: Container(
                                                    child: Image.asset(
                                                      "assets/images/tapeedit.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  id: int.parse(fullSongs[index]
                                                      .metas
                                                      .id
                                                      .toString()),
                                                  type: ArtworkType.AUDIO)),
                                          const SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: width * .45,
                                                child: textHomeFunction(
                                                    fullSongs[index]
                                                        .metas
                                                        .title!,
                                                    14),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  child: textHomeSubFunction(
                                                      fullSongs[index]
                                                                  .metas
                                                                  .artist! ==
                                                              "<unknown>"
                                                          ? "Unknown Artist"
                                                          : fullSongs[index]
                                                              .metas
                                                              .artist!,
                                                      10)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              child: favouriteSongs!
                                                      .where((element) =>
                                                          element.id
                                                              .toString() ==
                                                          cache.id.toString())
                                                      .isEmpty
                                                  ? const Icon(Icons.play_arrow)
                                                  : const Icon(
                                                      Icons.play_arrow,
                                                      color: Colors.black,
                                                    )),
                                          Container(
                                            child: StatefulBuilder(
                                              builder: (context, setState) {
                                                return PopupMenu(
                                                    id: fullSongs[index]
                                                        .metas
                                                        .id
                                                        .toString());
                                              },
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                itemCount: fullSongs.length,
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
    ));
  }

  void playSong() {
    setState(() {
      if (isTapped) {
        player.play();
      } else {
        player.pause();
      }
    });
  }

  AllAudios savedSongs(List<AllAudios> audios, String id) {
    /////Funct ion
    return audios.firstWhere((element) => element.id.toString().contains(id));
  }
}

class DurationState {
  DurationState({this.position = Duration.zero, this.total = Duration.zero});
  Duration position, total;
}
