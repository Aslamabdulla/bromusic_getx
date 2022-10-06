import 'package:bromusic/main.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/menu_item/playlist-dialog.dart';
import 'package:bromusic/view/screens/all_songs/all_songs.dart';
import 'package:bromusic/view/screens/find_music/find_music.dart';
import 'package:bromusic/view/screens/home_page/home_page.dart';
import 'package:bromusic/view/screens/now_playing/now_playing.dart';
import 'package:bromusic/view/search/search.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:on_audio_query/on_audio_query.dart';

class NavigationRouting extends StatefulWidget {
  const NavigationRouting({
    Key? key,
    required this.user,
  }) : super(key: key);
  final String user;

  @override
  State<NavigationRouting> createState() => _NavigationRoutingState();
}

class _NavigationRoutingState extends State<NavigationRouting> {
  final audioQuery = OnAudioQuery();
  var iconsize = 30;
  late String user1 = widget.user;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _currentSelectedIndex = 1;
  int selectindex = 1;
  List screenNames = const ["ALL SONGS", "HOME", "FIND MUSIC"];
  String? title;
  int? index1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      AllSongs(),
      Homepage(name: widget.user),
      // NowPlayingScreen(),
      const FindMusic(),
    ];

    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return SafeArea(
      child: Scaffold(
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
                  Get.to(() => NowPlayingScreen());
                },
                icon: const Icon(
                  Icons.settings_input_antenna,
                  size: 25,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    _currentSelectedIndex = 2;
                    title = "FIND MUSIC";
                  });
                },
                icon: const Icon(
                  Icons.hearing,
                  size: 25,
                )),
            Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (ctx) {
                      return const SearchScreen();
                    }));
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
              index: _currentSelectedIndex,
              height: 60,
              buttonBackgroundColor: switched.value
                  ? commonRed()
                  : const Color.fromRGBO(255, 201, 0, 1),
              backgroundColor: Colors.transparent,
              color: switched.value
                  ? commonRed()
                  : const Color.fromRGBO(255, 201, 0, 1),
              key: _bottomNavigationKey,
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
                setState(() {
                  _currentSelectedIndex = index;
                  selectindex = index;
                  title = screenNames[index];
                });
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
              decoration: _currentSelectedIndex == 2
                  ? boxDecorationImage2()
                  : boxDecorationImage(),
              child: pages[_currentSelectedIndex],
            );
          }),
        ),
      ),
    );
  }
}
