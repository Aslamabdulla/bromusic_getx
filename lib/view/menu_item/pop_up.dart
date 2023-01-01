import 'package:bromusic/dependencies/dependencies.dart';
import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';

import 'package:bromusic/view/playlist/playlist.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class PopupMenu extends StatelessWidget {
  final String id;

  PopupMenu({Key? key, required this.id}) : super(key: key);

  final box = SongBox.getInstance();

  @override
  Widget build(BuildContext context) {
    favouriteController.dataBaseSongs = box.get("music") as List<AllAudios>;
    List? favouriteSongs = box.get("favourites");
    final cache = savedSongs(favouriteController.dataBaseSongs, id);
    return PopupMenuButton(
      itemBuilder: (BuildContext ctx) => [
        favouriteSongs!
                .where(
                    (element) => element.id.toString() == cache.id.toString())
                .isEmpty
            ? PopupMenuItem(
                value: "0",
                onTap: () async {
                  favouriteController.popupAddFav(cache, favouriteSongs);
                  snakBar(context, "added to favourites", cache.title!);
                },
                child: ListTile(
                  leading: const Icon(Icons.favorite_outline_outlined),
                  title: textHomeFunction('Add to Favourites', 11),
                ))
            : PopupMenuItem(
                value: "0",
                onTap: () async {
                  favouriteController.popupRemoveFav(cache, favouriteSongs);
                  snakBar(context, "removed from Favourites", cache.title!);
                },
                child: ListTile(
                  leading: const Icon(Icons.favorite),
                  title: textHomeFunction('Remove from Favourites ', 11),
                )),
        PopupMenuItem(
            value: "1",
            child: ListTile(
              leading: const Icon(Icons.playlist_add),
              title: textHomeFunction('Add to playlist', 11),
            ))
      ],
      onSelected: (value) async {
        if (value == "1") {
          showModalBottomSheet(
              context: context,
              builder: (context) => PlaylistScreen(song: cache));
          snakBar(context, "select playlist", cache.title!);
        }
      },
      icon: const Icon(Icons.more_vert),
    );
  }

  AllAudios savedSongs(List<AllAudios> audios, String id) {
    /////Funct ion
    return audios.firstWhere((element) => element.id.toString().contains(id));
  }

  snakBar(BuildContext context, String dialogue, String temp) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "$temp $dialogue",
        style: GoogleFonts.oswald(
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
      duration: const Duration(seconds: 1),
    ));
  }
}
