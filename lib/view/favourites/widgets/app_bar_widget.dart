import 'package:bromusic/controller/controller.dart';
import 'package:bromusic/main.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/screens/now_playing.dart';
import 'package:bromusic/view/screens/routing.dart';
import 'package:bromusic/view/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarFavourite extends StatelessWidget {
  const AppBarFavourite({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MusicController>(
        init: MusicController(),
        builder: (MusicController musicController) {
          return AppBar(
            leadingWidth: 70,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.chevron_left,
                size: 30,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.to(() => NowPlayingScreen(
                        fullSongs: musicController.fullSongs, index: 0));
                  },
                  icon: const Icon(
                    Icons.settings_input_antenna,
                    size: 30,
                  )),
              Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) {
                            return const SearchScreen();
                          },
                        ));
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 35,
                      ))),
            ],
            iconTheme: const IconThemeData(color: Colors.black),
            automaticallyImplyLeading: true,
            centerTitle: true,
            title: Text(
              "FAVOURITES",
              style: textHead(),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          );
        });
  }
}
