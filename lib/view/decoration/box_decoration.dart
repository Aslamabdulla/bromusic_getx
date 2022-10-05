import 'package:animate_do/animate_do.dart';

import 'package:bromusic/main.dart';

import 'package:bromusic/view/common_widgets/colors.dart';
import 'package:bromusic/view/common_widgets/settings.dart';
import 'package:bromusic/view/screens/splash_screen/splash_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ValueNotifier<bool> switched = ValueNotifier(false);

boxDecorTwoEdge() {
  return BoxDecoration(
      gradient: LinearGradient(
          colors: switched.value
              ? [
                  const Color.fromRGBO(255, 110, 6, .9),
                  const Color.fromRGBO(255, 110, 6, .4),
                ]
              : [
                  const Color.fromRGBO(255, 201, 0, .9),
                  const Color.fromRGBO(255, 201, 0, .4),
                ],
          stops: const [.4, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
      borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(190), bottomLeft: Radius.circular(190)));
}

boxDecorAllEdge() {
  return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/headset.png"), fit: BoxFit.contain),
      borderRadius: BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.25),
          blurRadius: 1,
          spreadRadius: 0,
          offset: Offset(0, 4.0),
        ),
      ]);
}

boxDecorSettings() {
  return BoxDecoration(
      gradient: LinearGradient(
          colors: switched.value
              ? [
                  const Color.fromRGBO(200, 228, 241, 1),
                  const Color.fromRGBO(180, 210, 230, 1),
                ]
              : [
                  const Color.fromRGBO(200, 228, 241, 1),
                  const Color.fromRGBO(180, 210, 230, 1),
                ],
          stops: const [.4, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
      // color: const Color.fromRGBO(200, 228, 241, .5),
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(200, 228, 241, 1),
          blurRadius: 3,
          spreadRadius: 1,
          offset: Offset(0, 0),
        ),
      ],
      borderRadius: BorderRadius.circular(20));
}

boxDecorSongsTitle() {
  return const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
}

imageContainer() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.network(
      "https://liveforlivemusic.com/features/10-positive-benefits-of-listening-to-music-according-to-science/",
      height: 200,
      width: 200,
    ),
  );
}

boxDecorRedTwoEdge() {
  return BoxDecoration(
      color: commonRed(),
      borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(190), bottomLeft: Radius.circular(190)));
}

boxDecorationImage() {
  return BoxDecoration(
    image: DecorationImage(
        image: switched.value
            ? const AssetImage("assets/images/backgroundred.png")
            : const AssetImage("assets/images/backgroundbg.png"),
        fit: BoxFit.cover),
  );
}

boxDecorationImage2() {
  return BoxDecoration(
    image: DecorationImage(
        image: switched.value
            ? const AssetImage("assets/images/backgroundredfind.png")
            : const AssetImage("assets/images/backgroungfind.png"),
        fit: BoxFit.cover),
  );
}

boxDecorationImageSearch() {
  return BoxDecoration(
    image: DecorationImage(
        image: switched.value
            ? const AssetImage("assets/images/backgroundplay.png")
            : const AssetImage("assets/images/search.png"),
        fit: BoxFit.cover),
  );
}

drawerFunction(ValueNotifier<bool> switched, BuildContext context) {
  return ElasticInLeft(
    duration: const Duration(milliseconds: 600),
    child: Drawer(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      width: 325,
      elevation: 3,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          ValueListenableBuilder(
            valueListenable: switched,
            builder: (context, value, _) {
              return DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    switched.value
                        ? const Color.fromRGBO(255, 110, 6, .8)
                        : const Color.fromRGBO(255, 201, 0, 1),
                    switched.value
                        ? const Color.fromRGBO(255, 110, 6, .4)
                        : const Color.fromRGBO(255, 201, 0, .4),
                  ], stops: const [
                    .4,
                    1.0
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(120),
                      bottomLeft: Radius.circular(120)),
                ),
                child: Text(
                  'BROMUSIC',
                  style: textHead(),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
          ListTile(
            trailing: StatefulBuilder(
              builder: (context, setState) {
                return Switch(
                    inactiveThumbColor: commonYellow(),
                    inactiveTrackColor: commonYellow(),
                    value: switched.value,
                    onChanged: (value) {
                      setState(() {
                        if (switched.value == false) {
                          switched.value = true;
                        } else {
                          switched.value = false;
                        }
                      });
                      preference.setBool("theme", switched.value);
                    });
              },
            ),
            title: textHomeFunction('Switch Theme', 15),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: textHomeFunction('Settings', 15),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) {
                  return const SettingsScreen();
                },
              ));
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    ),
  );
}

appBarFun() {
  return AppBar(
    leadingWidth: 70,
    actions: const [
      Padding(
        padding: EdgeInsets.only(right: 15.0),
        child: Icon(Icons.search),
      ),
    ],
    iconTheme: const IconThemeData(color: Colors.black),
    automaticallyImplyLeading: true,
    centerTitle: true,
    title: Text(
      "HOME",
      style: textHead(),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

appBarSongs(var context, int selectindex) {
  List screenNames = const ["ALL SONGS", "HOME", "NOWPLAYING"];
  return AppBar(
    leadingWidth: 70,
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.hearing,
            size: 30,
          )),
      Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return const SplashScreen();
              }));
            },
            icon: const Icon(
              Icons.search,
              size: 40,
            ),
          )),
    ],
    iconTheme: const IconThemeData(color: Colors.black),
    automaticallyImplyLeading: true,
    centerTitle: true,
    title: Text(
      screenNames[selectindex],
      style: textHead(),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

appbarNow() {
  return AppBar(
    elevation: 0,
    title: Text("BROMUSIC", style: textHead()),
    centerTitle: true,
  );
}

boxDecorHomeEdge() {
  return const BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(255, 255, 255, .8),
          blurRadius: 0,
          spreadRadius: 0,
          offset: Offset(0, 0),
        ),
      ]);
}

appBarFind(String text) {
  return AppBar(
    leadingWidth: 70,
    actions: const [
      Padding(
        padding: EdgeInsets.only(right: 15.0),
        child: Icon(Icons.search),
      ),
    ],
    iconTheme: const IconThemeData(color: Colors.black),
    automaticallyImplyLeading: true,
    centerTitle: true,
    title: Text(
      "HOME",
      style: textHead(),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
  );
}

boxDecorMiniAllEdge() {
  return const BoxDecoration(
    image: DecorationImage(
        image: AssetImage("assets/images/mini.png"), fit: BoxFit.cover),
    borderRadius: BorderRadius.all(Radius.circular(40)),
  );
}
