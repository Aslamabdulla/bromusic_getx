import 'package:bromusic/model/box_model.dart';
import 'package:get/get.dart';

class RecentController extends GetxController {
  final box = SongBox.getInstance();
  removeRecent(int index, List<dynamic> playlistAudios) async {
    await playlistAudios.removeAt(index);
    box.put("recent", playlistAudios);
    update();
  }
}
