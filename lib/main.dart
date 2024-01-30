import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/controller/controller.dart';
import 'package:bromusic/dependencies/dependencies.dart';
import 'package:bromusic/routes/routes.dart';

import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/decoration/box_decoration.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences preference;

bool? temp;

Future<void> main() async {
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });

  await Hive.initFlutter();
  Hive.registerAdapter(AllAudiosAdapter());
  await Hive.openBox<AllAudios>('allsongs');
  await Hive.openBox<List>(boxName);

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
    runApp(MyApp());
  });
}

bool firsttime = true;

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final box = SongBox.getInstance();
  final player = AssetsAudioPlayer.withId("0");

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MusicController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bromusic',
      theme: ThemeData(
          primarySwatch: switched.value ? Colors.deepOrange : Colors.amber),
      initialRoute:
          firsttime ? RoutesClass.getSplashRoute() : RoutesClass.getNavRoute(),
      getPages: RoutesClass.routes,
    );
  }
}
