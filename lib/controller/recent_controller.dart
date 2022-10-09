import 'package:bromusic/model/box_model.dart';
import 'package:get/get.dart';

class RecentController extends GetxController {
  List existingSong = [];
  final box = SongBox.getInstance();
  removeRecent(int index, List<dynamic> playlistAudios) async {
    await playlistAudios.removeAt(index);
    box.put("recent", playlistAudios);
    update();
  }

  addRecent(List<dynamic> recentlyPlay, AllAudios cache) async {
    existingSong = recentlyPlay
        .where((element) => element.id.toString() == cache.id.toString())
        .toList();
    if (existingSong.isEmpty) {
      recentlyPlay.add(cache);
      var temp = recentlyPlay.toSet().toList();
      if (temp.length > 15) {
        temp.removeAt(0);
      }

      await box.put("recent", temp);
    }
    update();
  }
}
