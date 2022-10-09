import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/model/box_model.dart';
import 'package:bromusic/view/screens/now_playing/now_playing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicController extends GetxController {
  // with GetTickerProviderStateMixin
  final box = SongBox.getInstance();
  List<Audio> fullSongs = <Audio>[].obs;
  List<AllAudios> mappedSongs = <AllAudios>[].obs;
  List<AllAudios> dataBaseSongs = <AllAudios>[].obs;
  List<SongModel> fetchedSongs = <SongModel>[].obs;
  List<SongModel> allSongs = <SongModel>[].obs;
  List playlistName = <dynamic>[].obs;
  List<dynamic>? favSongs = <dynamic>[].obs;
  bool playing = false;
  double volume = 1;

  bool nextDone = true;
  bool prevDone = true;

  bool isPlay = true;
  List? favouriteSongs = [];

  int currentIndex = 1;

  @override
  void onInit() {
    songFetch();
    favCheck();
    // animationRotate();
    super.onInit();
  }

  @override
  void dispose() {
    // animationController;
    super.dispose();
  }

  bottomNavigation(int newIndex) {
    currentIndex = newIndex;
    update();
  }

  final player = AssetsAudioPlayer.withId("0");
  final _audioQuery = OnAudioQuery();
  void requestPermission() {
    Permission.storage.request();
  }

  favCheck() {
    favSongs = box.get('favourites');
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
            id: audio.id,
            count: 0))
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
          image: MetasImage.asset(
            element.path!,
          ),
        ),
      ));
    }
    update();
  }

  popupAddFav(AllAudios cache, List<dynamic> favouriteSongs) async {
    favouriteSongs.add(cache);

    await box.put("favourites", favouriteSongs);

    update();
  }

  popupRemoveFav(AllAudios cache, List<dynamic> favouriteSongs) async {
    favouriteSongs
        .removeWhere((element) => element.id.toString() == cache.id.toString());
    await box.put("favourites", favouriteSongs);
    update();
  }

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  nowPlayingAudio(Audio mySongs) {
    dataBaseSongs.firstWhere(
        (element) => element.id.toString() == mySongs.metas.id.toString());
  }

  Future<void> favMiniIconAdd(
    List<dynamic> favSongs,
    AllAudios audio,
  ) async {
    favSongs.add(audio);
    box.put('favourites', favSongs);
    update();
  }

  Future<void> favMiniRemove(List<dynamic> favSongs, AllAudios audios) async {
    favSongs.removeWhere(
        (element) => element.id.toString() == audios.id.toString());
    box.put('favourites', favSongs);
    update();
  }
}
