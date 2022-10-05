import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/common.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/screens/mini_player/mini_player.dart';
import 'package:bromusic/view/screens/player/player.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({Key? key}) : super(key: key);

  @override
  State<RecentScreen> createState() => _RecentScreenState();
}

class _RecentScreenState extends State<RecentScreen> {
  final box = SongBox.getInstance();
  List<AllAudios>? dataBaseSongs = [];
  List<AllAudios>? playlistAudios = [];
  List<Audio> playlistPlay = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      // width: width,
      // height: height,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 2,
              child: ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: ((context, boxes, _) {
                  var playlistAudios = box.get("recent")!;

                  return playlistAudios.isEmpty
                      ? SizedBox(
                          child: Center(
                          child: textHomeFunction("PLEASE PLAY SOME SONGS", 14),
                        ))
                      : Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () async {
                                    for (var element in playlistAudios) {
                                      playlistPlay.add(Audio.file(element.path!,
                                          metas: Metas(
                                            title: element.title,
                                            id: element.id.toString(),
                                            artist: element.artist,
                                          )));
                                    }
                                    CurrentlyPlaying(
                                            fullSongs: playlistPlay,
                                            index: index)
                                        .openAudioPlayer(
                                            index: index, audios: playlistPlay);

                                    await showBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        clipBehavior: Clip.hardEdge,
                                        context: context,
                                        builder: (context) => MiniPlayer(
                                            allSongs: playlistPlay,
                                            index: index));
                                  },
                                  child: ValueListenableBuilder(
                                    valueListenable: switched,
                                    builder: (context, value, _) => Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: playlistBoxDecoration(),
                                        width: width,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration:
                                                      boxDecorSongsTitle(),
                                                  width: 80,
                                                  height: 70,
                                                  child: QueryArtworkWidget(
                                                      artworkClipBehavior:
                                                          Clip.none,
                                                      artworkFit: BoxFit.cover,
                                                      nullArtworkWidget:
                                                          Container(
                                                        child: Image.asset(
                                                          "assets/images/tapeedit.png",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      id: playlistAudios[index]
                                                          .id,
                                                      type: ArtworkType.AUDIO)),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: width * .45,
                                                    child: textHomeFunction(
                                                        playlistAudios[index]
                                                            .title,
                                                        14),
                                                  ),
                                                  SizedBox(
                                                    width: width * .40,
                                                    child: textHomeSubFunction(
                                                        playlistAudios[index]
                                                            .artist,
                                                        12),
                                                  )
                                                ],
                                              ),
                                              PopupMenuButton(
                                                  itemBuilder:
                                                      (BuildContext context) =>
                                                          [
                                                            PopupMenuItem(
                                                                value: "1",
                                                                child: textHomeFunction(
                                                                    "Remove Song",
                                                                    12)),
                                                          ],
                                                  onSelected: (value) {
                                                    if (value == "1") {
                                                      showDialog(
                                                          context: context,
                                                          builder:
                                                              (context) =>
                                                                  AlertDialog(
                                                                    title:
                                                                        Center(
                                                                      child: textHomeFunction(
                                                                          "PLEASE CONFIRM DELETION",
                                                                          16),
                                                                    ),
                                                                    content:
                                                                        Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        TextButton.icon(
                                                                            onPressed: () {
                                                                              playlistAudios.removeAt(index);
                                                                              box.put("recent", playlistAudios);

                                                                              Navigator.pop(context);
                                                                            },
                                                                            icon: const Icon(
                                                                              Icons.check,
                                                                              color: Colors.greenAccent,
                                                                            ),
                                                                            label: textHomeFunction("YES", 14)),
                                                                        TextButton.icon(
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            icon: const Icon(
                                                                              Icons.close,
                                                                              color: Colors.redAccent,
                                                                            ),
                                                                            label: textHomeFunction("NO", 14)),
                                                                      ],
                                                                    ),
                                                                  ));

                                                      // openEditDialog(
                                                      //     context, playlistName[index]);
                                                    }
                                                  })
                                            ])),
                                  ));
                            },
                            itemCount: playlistAudios.length,
                            // item.data!.length,
                          ),
                        );
                }),
              )),
        ],
      ),
    );
  }
}
