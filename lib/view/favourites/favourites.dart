// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/controller/favourite_controller.dart';

import 'package:bromusic/view/favourites/widgets/app_bar_widget.dart';
import 'package:bromusic/view/favourites/widgets/fav_list_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/common.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';

import 'package:bromusic/view/screens/mini_player/mini_player.dart';
import 'package:bromusic/view/screens/now_playing/now_playing.dart';
import 'package:bromusic/view/screens/player/player.dart';

List<AllAudios>? dataBaseSongs = [];
List<dynamic> favSongs = [];
List<Audio> favAudios = [];

class FavouritesScreen extends StatelessWidget {
  FavouritesScreen({super.key});

  final box = SongBox.getInstance();

  int selectindex = 1;

  var iconsize = 30;

  @override
  Widget build(BuildContext context) {
    favSongs = box.get("favourites") as List<dynamic>;
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50), child: AppBarFavourite()),
        body: GetBuilder<FavouriteController>(
            init: FavouriteController(),
            builder: (FavouriteController favMusic) {
              return Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: boxDecorationImage(),
                child: Column(
                  children: [
                    Expanded(
                        child: favSongs.isEmpty
                            ? Center(
                                child: Text(
                                  "Favourites Is Empty",
                                  style: textWelcomeSub2(),
                                ),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  height: 10,
                                ),
                                itemBuilder: (context, index) {
                                  return SlideInRight(
                                    child: GetBuilder<FavouriteController>(
                                        init: FavouriteController(),
                                        builder:
                                            (FavouriteController favMusic) {
                                          return Container(
                                            margin: const EdgeInsets.fromLTRB(
                                                5, 0, 5, 0),
                                            decoration: playlistBoxDecoration(),
                                            child: GestureDetector(
                                              onDoubleTap: () {
                                                Get.to(
                                                    transition: Transition
                                                        .leftToRightWithFade,
                                                    () => NowPlayingScreen());
                                              },
                                              onTap: () async {
                                                for (var element in favSongs) {
                                                  favAudios.add(Audio.file(
                                                    element.path!,
                                                    metas: Metas(
                                                      title: element.title
                                                          .toString(),
                                                      id: element.id.toString(),
                                                      artist: element.artist,
                                                    ),
                                                  ));
                                                }
                                                CurrentlyPlaying(
                                                        fullSongs: favAudios,
                                                        index: index)
                                                    .openAudioPlayer(
                                                        index: index,
                                                        audios: favAudios);
                                                await showBottomSheet(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    clipBehavior: Clip.hardEdge,
                                                    context: context,
                                                    builder: (context) =>
                                                        MiniPlayer(
                                                            index: index));
                                              },
                                              child: FavListTileWidget(
                                                  index: index,
                                                  favSongs: favSongs,
                                                  width: width),
                                            ),
                                          );
                                        }),
                                  );
                                },
                                itemCount: favSongs.length,
                              )),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
