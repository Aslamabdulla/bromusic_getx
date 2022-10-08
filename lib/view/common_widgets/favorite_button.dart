// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bromusic/controller/favourite_controller.dart';
import 'package:bromusic/controller/controller.dart';
import 'package:bromusic/main.dart';
import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';

FavouriteController favouriteController = Get.put(FavouriteController());

class FavIconWidget extends StatelessWidget {
  MusicController controller;
  final String songId;
  FavIconWidget({
    required Key key,
    required this.controller,
    required this.songId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List favSongs = favouriteController.box.get("favourites")!;
    final cache = savedSongs(favouriteController.dataBaseSongs, songId);
    return GetBuilder<FavouriteController>(
        init: FavouriteController(),
        builder: (FavouriteController favIconController) {
          favIconController.existingSong = favSongs
              .where((element) => element.id.toString() == cache.id.toString())
              .toList();

          return favIconController.existingSong.isEmpty
              ? IconButton(
                  onPressed: () async {
                    await favIconController.popupAddFav(cache, favSongs);
                    favSongs = favIconController.box.get("favourites")!;
                  },
                  icon: const Icon(
                    Icons.favorite_outline,
                    color: Colors.black,
                    size: 20,
                  ))
              : IconButton(
                  onPressed: () async {
                    await favIconController.popupRemoveFav(cache, favSongs);

                    favSongs = favIconController.box.get("favourites")!;
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: commonRed(),
                    size: 20,
                  ));
        });
  }

  AllAudios savedSongs(List<AllAudios> audios, String id) {
    /////Funct ion
    return audios.firstWhere((element) => element.id.toString().contains(id));
  }
}
