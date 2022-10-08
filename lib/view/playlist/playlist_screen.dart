import 'package:bromusic/controller/controller.dart';
import 'package:bromusic/controller/playlist_controller.dart';
import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/common.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/menu_item/edit_playlist.dart';
import 'package:bromusic/view/playlist/playlist.dart';
import 'package:bromusic/view/playlist/playlist_songs.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlaylistViewScreen extends StatelessWidget {
  const PlaylistViewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    String? playlistTitle = '';
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          leadingWidth: 70,
          actions: const [],
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
        body: GetBuilder<PlaylistController>(
            init: PlaylistController(),
            builder: (PlaylistController playlistController) {
              return Container(
                padding: const EdgeInsets.fromLTRB(15, 50, 15, 5),
                // width: width,
                // height: height,
                decoration: boxDecorationImage(),
                child: Column(
                  children: [
                    Expanded(
                        child: ValueListenableBuilder(
                      valueListenable: playlistController.box.listenable(),
                      builder: ((context, boxes, _) {
                        playlistController.playlistName =
                            playlistController.box.keys.toList();
                        // playlistController.playlistName[index] !=
                        //             "music" &&
                        //         playlistController.playlistName[index] !=
                        //             "favourites" &&
                        //         playlistController.playlistName[index] !=
                        //             "identified" &&
                        //         playlistController.playlistName[index] !=
                        //             "recent"

                        return playlistController.playlistName.length == 4
                            ? Center(
                                child: Text(
                                  "Please Add Playlist",
                                  style: textWelcomeSub2(),
                                ),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 10,
                                ),
                                itemBuilder: (context, index) {
                                  playlistController.playlistName.removeWhere(
                                      (element) => element == 'favourites');
                                  playlistController.playlistName.removeWhere(
                                      (element) => element == "music");
                                  playlistController.playlistName.removeWhere(
                                      (element) => element == "identified");
                                  playlistController.playlistName.removeWhere(
                                      (element) => element == "recent");
                                  return GestureDetector(
                                      onTap: (() {
                                        Navigator.of(context).push(
                                            CupertinoPageRoute(
                                                builder: (context) {
                                          return PlaylistSongsView(
                                              playlistName: playlistController
                                                  .playlistName[index]);
                                        }));
                                      }),
                                      child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: playlistBoxDecoration(),
                                          width: width,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: height * .10,
                                                  child: Image.asset(
                                                    "assets/images/tape.png",
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    textHomeFunction(
                                                        playlistController
                                                                .playlistName[
                                                            index],
                                                        16),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    textHomeSubFunction(
                                                        "User Playlist ${index + 1}",
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
                                                                  "Rename Playlist",
                                                                  12)),
                                                          PopupMenuItem(
                                                              value: "0",
                                                              child: textHomeFunction(
                                                                  "Remove Playlist",
                                                                  12)),
                                                        ],
                                                    onSelected: (value) {
                                                      if (value == "0") {
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
                                                                                playlistController.deletePlaylist(index);
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
                                                      if (value == "1") {
                                                        openEditDialog(
                                                            context,
                                                            playlistController
                                                                    .playlistName[
                                                                index]);
                                                      }
                                                    })
                                              ])));
                                },
                                itemCount:
                                    playlistController.playlistName.length - 4,
                                // item.data!.length,
                              );
                      }),
                    )),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
