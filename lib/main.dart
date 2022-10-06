import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/controller/controller.dart';

import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/screens/splash_screen/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'view/screens/home_page/home_page.dart';

late SharedPreferences preference;

bool? temp;
final MusicController musicController = MusicController();

Future<void> main() async {
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });
  // await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );
  await Hive.initFlutter();
  Hive.registerAdapter(AllAudiosAdapter());
  await Hive.openBox<AllAudios>('allsongs');
  await Hive.openBox<List>(boxName);

  final box = SongBox.getInstance();
  List<dynamic> favBoxKeys = box.keys.toList();
  if (!favBoxKeys.contains("favourites")) {
    List<dynamic> favSongs = [];
    await box.put("favourites", favSongs);
  }
  List<dynamic> findSongKeys = box.keys.toList();
  if (!findSongKeys.contains("identified")) {
    List<dynamic> identifiedSong = [];
    await box.put("identified", identifiedSong);
  }
  List<dynamic> recentSongKeys = box.keys.toList();
  if (!recentSongKeys.contains("recent")) {
    List<dynamic> recentSongs = [];
    await box.put("recent", recentSongs);
  }

  WidgetsFlutterBinding.ensureInitialized();
  preference = await SharedPreferences.getInstance();
  temp = preference.getBool("theme");
  if (temp == null) {
    switched.value = false;
  } else {
    switched.value = temp!;
  }
  musicController.songFetch();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

bool firsttime = true;

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final box = SongBox.getInstance();
  final player = AssetsAudioPlayer.withId("0");
  final _audioQuery = OnAudioQuery();
  void requestPermission() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bromusic',
      theme: ThemeData(
          primarySwatch: switched.value ? Colors.deepOrange : Colors.amber),
      home: firsttime
          ? SplashScreen()
          : const Homepage(
              name: "GUEST",
            ),
    );
  }
}
