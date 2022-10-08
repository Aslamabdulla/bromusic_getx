import 'package:bromusic/controller/favourite_controller.dart';
import 'package:bromusic/view/menu_item/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RowMoreButton extends StatelessWidget {
  int index;
  RowMoreButton({
    Key? key,
    required this.index,
    required this.favSongs,
  }) : super(key: key);

  final List favSongs;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              //
            },
            icon: const Icon(Icons.play_arrow)),
        GetBuilder<FavouriteController>(
            init: FavouriteController(),
            builder: (FavouriteController favMusic) {
              return PopupMenu(
                id: favSongs[index].id!.toString(),
              );
            })
      ],
    );
  }
}
