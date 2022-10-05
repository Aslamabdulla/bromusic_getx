import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';
import 'package:bromusic/view/screens/home_page.dart';
import 'package:bromusic/view/screens/splash_screen/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences preference;
List<Audio> fullSongs = [];
List<AllAudios> mappedSongs = [];
List<AllAudios> dataBaseSongs = [];
List<SongModel> fetchedSongs = [];
List<SongModel> allSongs = [];

bool? temp;

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
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

bool firsttime = true;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final box = SongBox.getInstance();
  final player = AssetsAudioPlayer.withId("0");
  final _audioQuery = OnAudioQuery();

  // late AudioPlayer player;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    songFetch();

    // requestPermission();
  }

  void requestPermission() {
    Permission.storage.request();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: switched.value ? Colors.deepOrange : Colors.amber),
      home: firsttime
          ? const SplashScreen()
          : const Homepage(
              name: "GUEST",
            ),
    );
  }

  songFetch() async {
    bool permission = await _audioQuery.permissionsStatus();
    if (!permission) {
      await _audioQuery.permissionsRequest();
    }
    fetchedSongs = await _audioQuery.querySongs();
    for (var element in fetchedSongs) {
      if (element.fileExtension == "mp3") {
        allSongs.add(element);
      }
    }
    mappedSongs = allSongs
        .map((audio) => AllAudios(
            title: audio.title,
            artist: audio.artist,
            path: audio.uri,
            duration: audio.duration,
            id: audio.id))
        .toList();
    await box.put("music", mappedSongs);
    dataBaseSongs = box.get("music") as List<AllAudios>;

    for (var element in dataBaseSongs) {
      fullSongs.add(Audio.file(
        element.path.toString(),
        metas: Metas(
            title: element.title,
            id: element.id.toString(),
            artist: element.artist,
            image: MetasImage.asset(element.path!)),
      ));
    }
  }
}
