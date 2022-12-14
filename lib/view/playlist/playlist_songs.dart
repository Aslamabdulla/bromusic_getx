import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/controller/playlist_controller.dart';

import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/common.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';

import 'package:bromusic/view/screens/mini_player/mini_player.dart';
import 'package:bromusic/view/screens/player/player.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlaylistSongsView extends StatelessWidget {
  const PlaylistSongsView({Key? key, required this.playlistName})
      : super(key: key);
  final String playlistName;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          leadingWidth: 70,
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Icon(Icons.search),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: Text(
            "PLAYLISTS",
            style: textHead(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          // width: width,
          // height: height,
          decoration: boxDecorationImage(),
          child: Column(
            children: [
              Expanded(
                  child: GetBuilder<PlaylistController>(
                      init: PlaylistController(),
                      builder: (PlaylistController playlistController) {
                        var playlistAudios =
                            playlistController.box.get(playlistName)!;

                        return playlistAudios.isEmpty
                            ? SizedBox(
                                child: Center(
                                child: textHomeFunction(
                                    "PLEASE ADD SOME SONGS", 14),
                              ))
                            : Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 10,
                                  ),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () async {
                                          for (var element in playlistAudios) {
                                            playlistController.playlistPlay
                                                .add(Audio.file(element.path!,
                                                    metas: Metas(
                                                      title: element.title,
                                                      id: element.id.toString(),
                                                      artist: element.artist,
                                                    )));
                                          }
                                          CurrentlyPlaying(
                                                  fullSongs: playlistController
                                                      .playlistPlay,
                                                  index: index)
                                              .openAudioPlayer(
                                                  index: index,
                                                  audios: playlistController
                                                      .playlistPlay);

                                          await showBottomSheet(
                                              backgroundColor:
                                                  Colors.transparent,
                                              clipBehavior: Clip.hardEdge,
                                              context: context,
                                              builder: (context) =>
                                                  MiniPlayer(index: index));
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: playlistBoxDecoration(),
                                            width: width,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    height: height * .10,
                                                    child: Image.asset(
                                                      "assets/images/tape.png",
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: width * .56,
                                                        child: textHomeFunction(
                                                            playlistAudios[
                                                                    index]
                                                                .title,
                                                            16),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      textHomeSubFunction(
                                                          playlistAudios[index]
                                                              .artist,
                                                          12),
                                                    ],
                                                  ),
                                                  PopupMenuButton(
                                                      itemBuilder: (BuildContext
                                                              context) =>
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
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            TextButton.icon(
                                                                                onPressed: () {
                                                                                  playlistController.removePlayListSongs(playlistAudios, index);
                                                                                  playlistController.box.put(playlistName, playlistAudios);

                                                                                  Get.back();
                                                                                },
                                                                                icon: const Icon(
                                                                                  Icons.check,
                                                                                  color: Colors.greenAccent,
                                                                                ),
                                                                                label: textHomeFunction("YES", 14)),
                                                                            TextButton.icon(
                                                                                onPressed: () {
                                                                                  Get.back();
                                                                                },
                                                                                icon: const Icon(
                                                                                  Icons.close,
                                                                                  color: Colors.redAccent,
                                                                                ),
                                                                                label: textHomeFunction("NO", 14)),
                                                                          ],
                                                                        ),
                                                                      ));
                                                        }
                                                      })
                                                ])));
                                  },
                                  itemCount: playlistAudios.length,
                                ),
                              );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
