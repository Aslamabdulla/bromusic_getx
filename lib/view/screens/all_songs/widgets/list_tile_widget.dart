import 'package:bromusic/dependencies/dependencies.dart';
import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/common.dart';
import 'package:bromusic/view/menu_item/pop_up.dart';

import 'package:bromusic/view/screens/all_songs/widgets/text_widget.dart';
import 'package:bromusic/view/screens/all_songs/widgets/image_widget.dart';
import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final int index;
  const ListTileWidget({
    Key? key,
    required this.index,
    required this.width,
    required this.cache,
  }) : super(key: key);

  final double width;
  final AllAudios cache;

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ImageWidget(index: index),
                  const SizedBox(width: 5),
                  TextListTile(width: width, index: index),
                ],
              ),
              Row(
                children: [
                  Container(
                      child: musicController.favouriteSongs!
                              .where((element) =>
                                  element.id.toString() == cache.id.toString())
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
                            id: musicController.fullSongs[index].metas.id
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
  }
}
