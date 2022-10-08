import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/model/box_model.dart';
import 'package:get/get.dart';

class PlaylistController extends GetxController {
  List playlistName = [];
  List<dynamic>? playlistAudios = [];
  List<Audio> playlistPlay = [];
  final box = SongBox.getInstance();

  deletePlaylist(int index) {
    box.delete(playlistName[index]);

    playlistName = box.keys.toList();
    update();
  }

  addPlayList(String title, String currentPlaylistName) {
    List? playlistTitle = box.get(currentPlaylistName);
    box.put(title, playlistTitle!);
    box.delete(currentPlaylistName);
    Get.back();
    update();
  }

  removePlayListSongs(List<dynamic> playlistAudios, int index) {
    playlistAudios.removeAt(index);
    update();
  }
}
