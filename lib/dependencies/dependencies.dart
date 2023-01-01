import 'package:bromusic/controller/controller.dart';
import 'package:bromusic/controller/favourite_controller.dart';
import 'package:bromusic/controller/now_playing_controller.dart';
import 'package:bromusic/controller/playlist_controller.dart';
import 'package:bromusic/controller/recent_controller.dart';
import 'package:get/get.dart';

final MusicController musicController =
    Get.put(MusicController(), permanent: true);
final favouriteController = Get.put(FavouriteController());
final nowPlayingController = Get.put(NowPlayingController(), permanent: true);
final playlistController = Get.put(PlaylistController());
final recentController = Get.put(RecentController());
