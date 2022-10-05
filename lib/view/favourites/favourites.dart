// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/common.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/menu_item/pop_up.dart';
import 'package:bromusic/view/screens/mini_player/mini_player.dart';
import 'package:bromusic/view/screens/now_playing.dart';
import 'package:bromusic/view/screens/player/player.dart';
import 'package:bromusic/view/search/search.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:bromusic/model/box_model.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<AllAudios>? dataBaseSongs = [];
  List<Audio> favAudios = [];
  final box = SongBox.getInstance();

  int selectindex = 1;

  var iconsize = 30;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    int currentIndex = 0;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          leadingWidth: 70,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 35,
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) {
                          return const SearchScreen();
                        },
                      ));
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 35,
                    ))),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(
            "FAVOURITES",
            style: textHead(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          decoration: boxDecorationImage(),
          child: Column(
            children: [
              Expanded(
                  child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: ((context, value, child) {
                  final favSongs = box.get("favourites") as List<dynamic>;
                  return ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemBuilder: (context, index) {
                      return SlideInRight(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          decoration: playlistBoxDecoration(),
                          child: GestureDetector(
                            onDoubleTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: ((context) => NowPlayingScreen(
                                          fullSongs: favAudios,
                                          index: index))));
                            },
                            onTap: () async {
                              for (var element in favSongs) {
                                favAudios.add(Audio.file(
                                  element.path!,
                                  metas: Metas(
                                    title: element.title.toString(),
                                    id: element.id.toString(),
                                    artist: element.artist,
                                  ),
                                ));
                              }
                              CurrentlyPlaying(
                                      fullSongs: favAudios, index: index)
                                  .openAudioPlayer(
                                      index: index, audios: favAudios);
                              await showBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  clipBehavior: Clip.hardEdge,
                                  context: context,
                                  builder: (context) => MiniPlayer(
                                      allSongs: favAudios, index: index));
                              currentIndex = index;
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              height: 100,
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
                                                  id: favSongs[index].id,
                                                  type: ArtworkType.AUDIO)),
                                          const SizedBox(width: 5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: width * .40,
                                                child: textHomeFunction(
                                                    favSongs[index].title!, 14),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  width: width * .40,
                                                  child: textHomeSubFunction(
                                                      favSongs[index].artist!,
                                                      10)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              child: IconButton(
                                                  onPressed: () {
                                                    //
                                                    setState(() {});
                                                  },
                                                  icon: const Icon(
                                                      Icons.play_arrow))),
                                          Container(
                                            child: PopupMenu(
                                                id: favSongs[index]
                                                    .id!
                                                    .toString()),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: favSongs.length,
                  );
                }),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
