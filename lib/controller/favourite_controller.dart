import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bromusic/model/box_model.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController {
  @override
  void onInit() {
    songfetch();
    favCheck();
    super.onInit();
  }

  List existingSong = [];
  List<AllAudios> dataBaseSongs = <AllAudios>[].obs;
  List<dynamic>? favSongs = <dynamic>[].obs;

  songfetch() async {
    dataBaseSongs = box.get("music") as List<AllAudios>;
  }

  favCheck() {
    favSongs = box.get('favourites');
  }

  final box = SongBox.getInstance();

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

  addFavourite(AllAudios currentAudio) {
    favSongs?.add(currentAudio);

    box.put("favourites", favSongs!);

    update();
  }

  removeFavourite(AllAudios currentAudio) {
    favSongs!.removeWhere(
        (element) => element.id.toString() == currentAudio.id.toString());

    box.put("favourites", favSongs!);

    update();
  }
}
