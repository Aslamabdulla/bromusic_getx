// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:bromusic/view/screens/home_page/widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bromusic/view/favourites/favourites.dart';
import 'package:bromusic/view/screens/top_beats/top_beats.dart';
import 'package:bromusic/view/playlist/playlist_screen.dart';
import 'package:bromusic/view/screens/onboarding/home_list.dart';

class UpperListViewWidget extends StatelessWidget {
  const UpperListViewWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: SlideInRight(
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                width: 32,
              ),
              ListTileWidget(
                height: height,
                width: width,
                image: "assets/images/headsetedited.png",
                name: "Favourites",
                subtitle: "Favourite songs",
                widget: FavouritesScreen(),
              ),
              const SizedBox(
                width: 25,
              ),
              ListTileWidget(
                height: height,
                width: width,
                image: "assets/images/tapeedited.png",
                name: "Playlists",
                subtitle: "Playlist Songs",
                widget: const PlaylistViewScreen(),
              ),
              const SizedBox(
                width: 25,
              ),
              ListTileWidget(
                height: height,
                width: width,
                image: "assets/images/4.png",
                name: "Top Beats",
                subtitle: "Top songs",
                widget: TopBeatsScreen(),
              ),
            ],
          ),
        ));
  }
}
