// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bromusic/controller/favourite_controller.dart';
import 'package:bromusic/dependencies/dependencies.dart';
import 'package:bromusic/model/box_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavRoundButton extends StatelessWidget {
  final String songId;
  FavRoundButton({
    Key? key,
    required this.songId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> favSongs = favouriteController.box.get('favourites')!;
    final cache = savedSongs(favouriteController.dataBaseSongs, songId);
    return GetBuilder<FavouriteController>(
      builder: (favouriteController) {
        favouriteController.existingSong = favSongs
            .where((element) => element.id.toString() == cache.id.toString())
            .toList();
        return favouriteController.existingSong.isEmpty
            ? Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(10, 4, 3, 1),
                ),
                child: IconButton(
                    onPressed: () async {
                      await favouriteController.popupAddFav(cache, favSongs);
                      favSongs = favouriteController.box.get("favourites")!;
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
                  color: Color.fromRGBO(10, 4, 3, 1),
                ),
                child: IconButton(
                    onPressed: () async {
                      await favouriteController.popupRemoveFav(cache, favSongs);

                      favSongs = favouriteController.box.get("favourites")!;
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.amberAccent,
                    )),
              );
      },
    );
  }

  AllAudios savedSongs(List<AllAudios> songs, String id) {
    return songs.firstWhere((element) => element.id.toString().contains(id));
  }
}
