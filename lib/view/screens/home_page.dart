// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animate_do/animate_do.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/favourites/favourites.dart';
import 'package:bromusic/view/favourites/top_beats.dart';
import 'package:bromusic/view/menu_item/recently_played.dart';
import 'package:bromusic/view/playlist/playlist_screen.dart';
import 'package:bromusic/view/screens/onboarding/home_list.dart';

import 'package:flutter/cupertino.dart';

class Homepage extends StatefulWidget {
  const Homepage({
    Key? key,
    required this.name,
  }) : super(key: key);
  final String name;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentindex = 1;
  var iconsize = 30;
  int page = 1;

  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 5, right: 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 55),
                    child: Text(
                      "Playlist",
                      style: textWelcomeSub(),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textHomeFunction("Hello,", 12),
                      textHomeFunction(widget.name, 18),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    child: SlideInRight(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(
                        width: 32,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(CupertinoPageRoute(builder: ((context) {
                            return FavouritesScreen();
                          })));
                        },
                        child: horizListHomeScreen(
                            "assets/images/headsetedited.png",
                            "Favourites",
                            "Favourite songs",
                            height,
                            width),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(CupertinoPageRoute(builder: ((context) {
                            return const PlaylistViewScreen();
                          })));
                        },
                        child: horizListHomeScreen(
                            "assets/images/tapeedited.png",
                            "Playlists",
                            "Playlist Songs",
                            height,
                            width),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(CupertinoPageRoute(builder: ((context) {
                            return const TopBeatsScreen();
                          })));
                        },
                        child: horizListHomeScreen("assets/images/4.png",
                            "Top Beats", "Top songs", height, width),
                      ),
                    ],
                  ),
                ))),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: textHomeFunction("Recently Played", 12)),
              ],
            ),
            const SizedBox(
              height: 0,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 0),
              height: height * .43,
              child: RecentScreen(),
            )
          ],
        ),
      ),
    );
  }
}
