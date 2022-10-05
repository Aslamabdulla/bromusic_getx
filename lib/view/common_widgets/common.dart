import 'package:animate_do/animate_do.dart';

import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';

import 'package:flutter/material.dart';

nowPlaying() {
  return SpinPerfect(
    duration: Duration(milliseconds: 2000),
    infinite: true,
    child: Container(
      height: 200,
      width: 200,
      margin: const EdgeInsets.all(75),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .4),
            blurRadius: 14,
            spreadRadius: 3,
            offset: Offset(0, 0.0),
          ),
        ],
        image: DecorationImage(
            image: AssetImage(
              "assets/images/album-cover.jpg",
            ),
            fit: BoxFit.cover),
        shape: BoxShape.circle,
      ),
    ),
  );
}

nowPlayingContaoner(var icon, double width, double height) {
  return Container(
    height: height,
    width: width,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color.fromRGBO(10, 4, 3, 1),
    ),
    child: Icon(
      icon,
      color: Colors.white,
      shadows: const [
        Shadow(
            color: Color.fromRGBO(2, 48, 71, 1),
            blurRadius: 15,
            offset: Offset(0, 4)),
        Shadow(
          color: Color.fromRGBO(2, 48, 71, 1),
          blurRadius: 15,
        ),
        Shadow(
          color: Color.fromARGB(255, 17, 70, 146),
          blurRadius: 15,
          offset: Offset(5, 0),
        ),
        Shadow(
          color: Color.fromARGB(255, 14, 52, 105),
          blurRadius: 15,
          offset: Offset(-10, 0),
        ),
        Shadow(
          color: Color.fromRGBO(255, 255, 255, .2),
          blurRadius: 15,
          offset: Offset(0, 0),
        ),
      ],
    ),
  );
}

miniplayerFavouriteButton(var icon, double width, double height) {
  return Container(
    height: height,
    width: width,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color.fromRGBO(10, 4, 3, 1),
    ),
    child: Icon(
      icon,
      size: 20,
      color: Colors.white,
      shadows: const [
        Shadow(
            color: Color.fromRGBO(2, 48, 71, 1),
            blurRadius: 15,
            offset: Offset(0, 4)),
        Shadow(
          color: Color.fromRGBO(2, 48, 71, 1),
          blurRadius: 15,
        ),
        Shadow(
          color: Color.fromARGB(255, 17, 70, 146),
          blurRadius: 15,
          offset: Offset(5, 0),
        ),
        Shadow(
          color: Color.fromARGB(255, 14, 52, 105),
          blurRadius: 15,
          offset: Offset(-10, 0),
        ),
        Shadow(
          color: Color.fromRGBO(255, 255, 255, .2),
          blurRadius: 15,
          offset: Offset(0, 0),
        ),
      ],
    ),
  );
}

playlistContainer(BuildContext context, int index, String image,
    String playlistAudios, var width, var height, String subText) {
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: playlistBoxDecoration(),
      width: width,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: height * .10,
          child: Image.asset(
            image,
          ),
        ),
        Column(
          children: [
            textHomeFunction(playlistAudios, 16),
            const SizedBox(
              height: 10,
            ),
            textHomeSubFunction("$subText $index", 12),
          ],
        ),
        PopupMenuButton(
            itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                      value: "0",
                      child: textHomeFunction("Rename Playlist", 12)),
                  PopupMenuItem(
                      value: "1",
                      child: textHomeFunction("Remove Playlist", 12)),
                ])
      ]));
}

playlistBoxDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(colors: [
      switched.value
          ? const Color.fromRGBO(255, 110, 6, .60)
          : const Color.fromRGBO(255, 201, 0, .60),
      const Color.fromRGBO(255, 255, 255, .60),
    ], stops: const [
      0.0,
      1.0
    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
    borderRadius: const BorderRadius.all(Radius.circular(15)),
    // color: Colors.white12.withOpacity(.8)
  );
}

miniPlayerBoxDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(colors: [
      switched.value
          ? const Color.fromRGBO(255, 110, 6, 1)
          : const Color.fromRGBO(255, 201, 0, 1),
      Colors.white.withOpacity(1),
      // Color.fromRGBO(255, 110, 6, 1),
    ], stops: const [
      0.3,
      1
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    // color: Colors.white12.withOpacity(.8)
  );
}

searchBoxDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(colors: [
      switched.value
          ? const Color.fromRGBO(255, 110, 6, .50)
          : const Color.fromRGBO(255, 201, 0, .70),
      const Color.fromRGBO(255, 255, 255, .80),
    ], stops: const [
      0.0,
      1.0
    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
    borderRadius: const BorderRadius.all(Radius.circular(15)),
    // color: Colors.white12.withOpacity(.8)
  );
}

playlistSongContainer(
    List<dynamic> playlistAudiosList,
    String playlistName,
    int index,
    String image,
    String playlistAudios,
    var width,
    var height,
    String subText) {
  return Container(
      padding: const EdgeInsets.all(10),
      decoration: playlistBoxDecoration(),
      width: width,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: height * .10,
          child: Image.asset(
            image,
          ),
        ),
        Column(
          children: [
            textHomeFunction(playlistAudios, 16),
            const SizedBox(
              height: 10,
            ),
            textHomeSubFunction("$subText $index", 12),
          ],
        ),
      ]));
}

settings(String title, String image) {
  return Container(
    height: 100,
    decoration: settingsBoxDecoration(),
    child: Center(
        child: Wrap(
      direction: Axis.horizontal,
      children: [],
    )),
  );
}

wrapBox() {
  return Wrap(
    children: [
      Container(
        child: Column(
          children: [Text("HELLO")],
        ),
      ),
      Container(
        child: Column(
          children: [Text("HELLO")],
        ),
      )
    ],
  );
}

settingsBoxDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(colors: [
      switched.value
          ? const Color.fromRGBO(255, 110, 6, .60)
          : const Color.fromRGBO(255, 201, 0, .60),
      const Color.fromRGBO(255, 255, 255, .70),
    ], stops: const [
      0.0,
      1.0
    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
    borderRadius: const BorderRadius.all(Radius.circular(15)),
    // color: Colors.white12.withOpacity(.8)
  );
}

settingsBox(IconData icons, String text) {
  return Container(
      decoration: boxDecorSettings(),
      height: 150,
      width: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icons,
            size: 50,
            color: Color.fromRGBO(2, 48, 71, 1),
          ),
          FittedBox(
              fit: BoxFit.contain,
              child:
                  textSettingsunction(text, 14, Color.fromRGBO(2, 48, 71, 1)))
        ],
      ));
}

terms() {
  return textAboutunction("' '", 12);
}
