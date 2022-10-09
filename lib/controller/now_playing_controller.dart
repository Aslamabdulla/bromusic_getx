import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';

class NowPlayingController extends GetxController {
  AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  bool shuffleSong = false;
  bool isLoopMode = false;
  bool isPlayMode = false;
  LoopMode looping = LoopMode.playlist;
  loopMode(LoopMode mode) {
    player.setLoopMode(mode);
    looping = mode;

    update();
  }
}
