import 'package:bromusic/controller/favourite_controller.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/favourites/widgets/image_widget.dart';
import 'package:bromusic/view/favourites/widgets/list_tile_items.dart';
import 'package:bromusic/view/favourites/widgets/moreWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavListTileWidget extends StatelessWidget {
  int index;
  FavListTileWidget({
    Key? key,
    required this.index,
    required this.favSongs,
    required this.width,
  }) : super(key: key);

  final List favSongs;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteController>(
        builder: (FavouriteController favMusic) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: boxDecorSongsTitle(),
                        width: 80,
                        height: 70,
                        child: ImageWidgetFavourites(
                          favSongs: favSongs,
                          index: index,
                        )),
                    const SizedBox(width: 5),
                    ListTileContentsWidget(
                        width: width, favSongs: favSongs, index: index),
                  ],
                ),
                RowMoreButton(
                  favSongs: favSongs,
                  index: index,
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}
