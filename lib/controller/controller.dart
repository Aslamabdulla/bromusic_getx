import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/model/box_model.dart';
import 'package:get/get.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class MusicController extends GetxController {
  List<Audio> fullSongs = <Audio>[].obs;
  List<AllAudios> mappedSongs = <AllAudios>[].obs;
  List<AllAudios> dataBaseSongs = <AllAudios>[].obs;
  List<SongModel> fetchedSongs = <SongModel>[].obs;
  List<SongModel> allSongs = <SongModel>[].obs;
  List playlistName = <dynamic>[].obs;
  List<dynamic>? favSongs = <dynamic>[].obs;
  // final allSongs = RxList<SongModel>([]);
  //  final fetchedSongs = RxList<SongModel>([]);
  //  final dataBaseSongs = RxList<AllAudios>([]);
  //  final mappedSongs = RxList<AllAudios>([]);
  //  final fullSongs = RxList<Audio>([]);

  @override
  void onInit() {
    songFetch();
    super.onInit();
  }

  final box = SongBox.getInstance();
  final player = AssetsAudioPlayer.withId("0").obs;
  final _audioQuery = OnAudioQuery();
  void requestPermission() {
    Permission.storage.request();
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

  deletePlaylist(int index) {
    box.delete(playlistName[index]);

    playlistName = box.keys.toList();
    update();
  }
}
