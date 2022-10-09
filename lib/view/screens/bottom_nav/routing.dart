// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:bromusic/controller/controller.dart';
import 'package:bromusic/main.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/menu_item/playlist-dialog.dart';
import 'package:bromusic/view/screens/all_songs/all_songs.dart';
import 'package:bromusic/view/screens/find_music/find_music.dart';
import 'package:bromusic/view/screens/home_page/home_page.dart';
import 'package:bromusic/view/screens/now_playing/now_playing.dart';
import 'package:bromusic/view/search/search.dart';

class NavigationRouting extends StatelessWidget {
  final String user;
  const NavigationRouting({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

    List screenNames = const ["ALL SONGS", "HOME", "FIND MUSIC"];
    String? title;

    final pages = [
      AllSongs(),
      Homepage(name: user),
      // NowPlayingScreen(),
      const FindMusic(),
    ];

    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
      child: GetBuilder<MusicController>(
          init: MusicController(),
          builder: (MusicController musicController) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              extendBody: true,
              drawer: drawerFunction(switched, context),
              appBar:
                  // _currentSelectedIndex == 1

                  AppBar(
                leadingWidth: 70,
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.to(() => NowPlayingScreen(),
                            transition: Transition.leftToRight,
                            duration: const Duration(milliseconds: 300));
                      },
                      icon: const Icon(
                        Icons.settings_input_antenna,
                        size: 25,
                      )),
                  IconButton(
                      onPressed: () {
                        title = "FIND MUSIC";
                        musicController.bottomNavigation(2);
                      },
                      icon: const Icon(
                        Icons.hearing,
                        size: 25,
                      )),
                  Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: IconButton(
                        onPressed: () {
                          Get.to(() => const SearchScreen(),
                              transition: Transition.leftToRight,
                              duration: const Duration(milliseconds: 300));
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 25,
                        ),
                      )),
                ],
                iconTheme: const IconThemeData(color: Colors.black),
                automaticallyImplyLeading: true,
                centerTitle: true,
                title: Text(
                  title ?? "HOME",
                  style: textHead(),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              bottomNavigationBar: ValueListenableBuilder(
                valueListenable: switched,
                builder: ((context, value, _) {
                  return CurvedNavigationBar(
                    index: musicController.currentIndex,
                    height: 60,
                    buttonBackgroundColor: switched.value
                        ? commonRed()
                        : const Color.fromRGBO(255, 201, 0, 1),
                    backgroundColor: Colors.transparent,
                    color: switched.value
                        ? commonRed()
                        : const Color.fromRGBO(255, 201, 0, 1),
                    key: bottomNavigationKey,
                    items: const <Widget>[
                      Icon(
                        Icons.library_music_rounded,
                        size: 40,
                        color: Color.fromRGBO(2, 48, 71, 1),
                      ),
                      Icon(Icons.home_rounded,
                          size: 40, color: Color.fromRGBO(2, 48, 71, 1)),
                      Icon(
                        Icons.hearing,
                        size: 40,
                        color: Color.fromRGBO(2, 48, 71, 1),
                      ),
                    ],
                    onTap: (index) {
                      title = screenNames[index];
                      musicController.bottomNavigation(index);
                    },
                  );
                }),
              ),
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.white,
              body: ValueListenableBuilder(
                valueListenable: switched,
                builder: ((context, value, child) {
                  return Container(
                    width: width,
                    height: height,
                    decoration: musicController.currentIndex == 2
                        ? boxDecorationImage2()
                        : boxDecorationImage(),
                    child: pages[musicController.currentIndex],
                  );
                }),
              ),
            );
          }),
    );
  }
}
